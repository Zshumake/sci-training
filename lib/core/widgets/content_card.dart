import 'package:flutter/material.dart';
import '../../data/models/module_model.dart';
import '../../core/theme/app_theme.dart';

class ContentCard extends StatelessWidget {
  final ModuleModel module;
  final int index;
  final VoidCallback onTap;

  const ContentCard({
    super.key,
    required this.module,
    required this.index,
    required this.onTap,
  });

  Color get _moduleColor {
    final colors = [
      AppTheme.fundamentalsColor,
      AppTheme.classificationColor,
      AppTheme.pathophysColor,
      AppTheme.bladderColor,
      AppTheme.bowelColor,
      AppTheme.adColor,
      AppTheme.respiratoryColor,
      AppTheme.cardiovascularColor,
      AppTheme.spasticityColor,
      AppTheme.painColor,
      AppTheme.pressureColor,
      AppTheme.sexualityColor,
      AppTheme.mskColor,
      AppTheme.rehabColor,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final numberLabel = '${index + 1}'.padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.borderSubtle, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Row(
                children: [
                  // Left color accent strip
                  Container(
                    width: 3,
                    height: 100,
                    color: _moduleColor,
                  ),
                  // Module number
                  SizedBox(
                    width: 48,
                    child: Center(
                      child: Text(
                        numberLabel,
                        style: AppTheme.monoFont(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _moduleColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            module.title,
                            style: AppTheme.displayFont(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            module.description,
                            style: AppTheme.bodyFont(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (module.highlights.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children:
                                  module.highlights.take(3).map((h) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: _moduleColor.withValues(
                                        alpha: 0.35,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    h,
                                    style: AppTheme.displayFont(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: _moduleColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  // Chevron
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: _moduleColor.withValues(alpha: 0.4),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
