import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaml/yaml.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/providers/locale_provider.dart';
import 'package:energy_blast/l10n/app_localizations.dart';
import 'package:energy_blast/shared/widgets/auto_text.dart';
import 'package:energy_blast/shared/widgets/cosmic_background.dart';

class LegalPage extends ConsumerStatefulWidget {
  final String title;
  final String assetPath;

  const LegalPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  ConsumerState<LegalPage> createState() => _LegalPageState();
}

class _LegalPageState extends ConsumerState<LegalPage> {
  String _content = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      final String yamlString = await rootBundle.loadString(widget.assetPath);

      if (!mounted) return;

      final Map yamlMap = loadYaml(yamlString);

      final langCode = ref.read(localeProvider).languageCode;
      String rawText = yamlMap[langCode] ?? yamlMap['en'] ?? 'Text not found';

      final appTitle = AppLocalizations.of(context).appTitle;
      final packageInfo = await PackageInfo.fromPlatform();

      rawText = rawText.replaceAll('{appName}', appTitle);
      rawText = rawText.replaceAll('{version}', packageInfo.version);

      if (mounted) {
        setState(() {
          _content = rawText;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _content = 'Error loading content.';
          _isLoading = false;
        });
      }
    }
  }

  // This function builds text with clickable links
  Widget _buildTextWithLinks(String text) {
    final RegExp urlRegExp = RegExp(r'(https?:\/\/[^\s]+)');
    final List<InlineSpan> spans = [];
    int start = 0;
    final matches = urlRegExp.allMatches(text);

    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }

      final url = match.group(0)!.trim();
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: AppColors.primary,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(url);
              if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                debugPrint('Could not launch $url');
              }
            },
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          height: 1.5,
        ),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: AutoText.singleLine(
          widget.title,
          style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: CosmicBackground(
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : Padding(
            padding: const EdgeInsets.all(AppConstants.paddingL),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(AppConstants.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(AppConstants.radiusM),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      child: _buildTextWithLinks(_content),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingM),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusM)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: AutoText.singleLine(
                    l10n.close,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}