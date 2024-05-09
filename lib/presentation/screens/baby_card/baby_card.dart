import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/data/service/audio_player.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BabyCardScreen extends StatefulWidget {
  const BabyCardScreen({super.key, required this.babyCard});
  final BabyCard babyCard;

  @override
  State<BabyCardScreen> createState() => _BabyCardScreenState();
}

class _BabyCardScreenState extends State<BabyCardScreen> {
  late AudioPlayerService _audioPlayerService;
  @override
  void initState() {
    _audioPlayerService = sl<AudioPlayerService>();
    final assetsPath = [
      widget.babyCard.audio,
      widget.babyCard.raw,
    ];
    _audioPlayerService.audioPlayerListPlay(assetsPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(widget.babyCard.color).withOpacity(0.3),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _top(),
            _image(),
            _bootom(),
          ],
        ),
      ),
    );
  }

  Widget _top() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppButton.close(
            onTap: context.pop,
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 6,
          color: AppColor.color2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          widget.babyCard.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _bootom() {
    final isRaw = widget.babyCard.raw != null;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment:
            isRaw ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
        children: [
          isRaw
              ? AppButton.raw(
                  onTap: () {
                    _audioPlayerService.audioPlayerPlay(
                      widget.babyCard.raw!,
                    );
                  },
                )
              : Container(),
          AppButton.audio(
            onTap: () {
              _audioPlayerService.audioPlayerPlay(
                widget.babyCard.audio,
              );
            },
          ),
        ],
      ),
    );
  }
}
