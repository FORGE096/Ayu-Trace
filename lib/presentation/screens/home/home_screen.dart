// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/log_rule.dart';
import '../../bloc/log/log_bloc.dart';
import '../../bloc/log/log_event.dart';
import '../../bloc/log/log_state.dart';
import '../../bloc/rules/rules_bloc.dart';
import '../../bloc/rules/rules_state.dart';
import '../../widgets/core/glass_container.dart';
import '../../widgets/home/glowing_orb.dart';

/// The main dashboard of Ayu Trace.
/// Displays a modern glassmorphic UI to select and parse Minecraft log files.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _pickAndProcessFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['log', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final rulesState = context.read<RulesBloc>().state;
      final List<LogRule> rules = (rulesState is RulesLoaded)
          ? rulesState.rules
          : <LogRule>[];
      context.read<LogBloc>().add(
        ProcessLogFileEvent(filePath: filePath, activeRules: rules),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient & Glowing Orbs
          Positioned(
            top: -100,
            left: -100,
            child: GlowingOrb(color: Colors.blueAccent, size: 300),
          ),
          Positioned(
            bottom: -50,
            right: -100,
            child: GlowingOrb(color: Colors.purpleAccent, size: 400),
          ),
          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ayu Trace',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => context.push('/settings'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Minecraft Server Log Analyzer',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // 3. Dropzone / Action Area (Glassmorphism)
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () => _pickAndProcessFile(context),
                        child: GlassContainer(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: 80,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Select Server Log File',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Supports heavy files up to 500MB+',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 4. State Listener to show status
                  BlocBuilder<LogBloc, LogState>(
                    builder: (context, state) {
                      if (state is LogProcessing) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else if (state is LogProcessSuccess) {
                        return Center(
                          child: Text(
                            'Parsed ${state.logs.length} lines successfully!',
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else if (state is LogProcessError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
