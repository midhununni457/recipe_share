import 'package:flutter/material.dart';

class InstructionsSection extends StatelessWidget {
  const InstructionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dictum vel ipsum ut pharetra. '
          'Morbi pharetra, lacus ac consectetur congue, ex leo dapibus enim, et laoreet mauris justo ut mi. '
          'Pellentesque ut pellentesque lacus, quis tempus nisi. Mauris ultricies leo eu nisl commodo, at convallis urna blandit. '
          'Duis egestas ornare quam, quis porta velit vulputate quis. Quisque rutrum in urna ac porta. '
          'Nunc eleifend et felis vitae tincidunt. Pellentesque sit amet velit augue. '
          'Vestibulum semper, nunc nec vehicula elementum, quam risus hendrerit lorem, quis porttitor dui libero ut eros. '
          'Ut tellus massa, faucibus vitae dapibus a, molestie et dolor. Nunc fermentum efficitur vestibulum.',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
