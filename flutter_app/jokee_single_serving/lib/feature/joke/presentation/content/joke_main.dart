import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokee_single_serving/core/res/images/images/image_asset.dart';
import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';
import 'package:jokee_single_serving/feature/joke/presentation/bloc/joke_bloc.dart';

import '../../common/common.dart';

class JokeMain extends StatelessWidget {
  const JokeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: kTextTabBarHeight,
          ),
          _buildHeader(),
          _buildBanner(),
          BlocBuilder<JokeBloc, JokeState>(
            buildWhen: (previous, current) => previous.joke != current.joke,
            builder: (context, state) {
              return Expanded(
                child: state.joke != null
                    ? SingleChildScrollView(
                        child: _buildJokeContent(state.joke?.joke ?? ''))
                    : _buildNoJoke(),
              );
            },
          ),
          BlocSelector<JokeBloc, JokeState, JokeModel?>(
            selector: (state) {
              return state.joke;
            },
            builder: (context, state) {
              return state != null
                  ? _buildVote(
                      context,
                    )
                  : const SizedBox.shrink();
            },
          ),
          const Divider(),
          _buildFotter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageAssets.images.logo.image(
            width: 50,
            height: 50,
          ),
          Row(
            children: [
              const Column(
                children: [
                  Text(
                    'Handicrafted by',
                    style: TextStyle(
                      color: JokeColor.footerText,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Jim HLS',
                    style: TextStyle(
                      color: JokeColor.mainTextColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: 50,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ImageAssets.images.flower.image(
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBanner() => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: JokeColor.bannerColor,
        ),
        child: const Column(
          children: [
            Text(
              'A joke a day keeps the doctor away',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Text(
              'If you joke wrong way, your teeth have to pay. (Serious)',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );

  Widget _buildJokeContent(String joke) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16),
      child: Text(
        joke,
        style: const TextStyle(
          color: JokeColor.mainTextColor,
        ),
      ),
    );
  }

  Widget _buildNoJoke() {
    return const Center(
        child: Text(
      "That's all the jokes for today! Come back another day!",
      style: TextStyle(
        color: JokeColor.mainTextColor,
      ),
    ));
  }

  Widget _buildVote(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          JokeButton(
            title: 'This is Funny!',
            color: JokeColor.agreeButtonColor,
            onPress: () {
              context.read<JokeBloc>().add(
                    const JokeEvent.onVoted(agree: true),
                  );
            },
          ),
          JokeButton(
            title: 'This is not Funny.',
            color: JokeColor.disAgreeButtonColor,
            onPress: () {
              context.read<JokeBloc>().add(
                    const JokeEvent.onVoted(agree: false),
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFotter() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: const Column(
          children: [
            Text(
              'This appis created as part of HIsolutions program. The materials contained on this website are provided for general information only and do not constitute any form of advice. HLS assumes no responsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may,arise from reliance on the information contained on this site.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: JokeColor.footerText,
                fontSize: 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Text(
                'Copyright 2021 HLS',
                style: TextStyle(
                  color: JokeColor.mainTextColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
}
