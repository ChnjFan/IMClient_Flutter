import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/styles/colors.dart';
import '../../component/toast.dart';
import 'chat_logic.dart';

/// 聊天底部输入栏。
///
/// 包含文本输入框、图片选择按钮（相册/拍照）和发送按钮。
class ChatInputBar extends StatefulWidget {
  final ChatLogic logic;

  const ChatInputBar({super.key, required this.logic});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  bool _showEmojiOptions = false;
  bool _showAddOptions = false;
  bool _isVoiceMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendText() {
    if (!mounted) return;
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    // 延迟到下一帧清空输入框，避免 controller.notifyListeners 与当前帧的重建冲突
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.clear();
    });
    widget.logic.sendTextMessage(text);
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _showAddOptions = false;
      _showEmojiOptions = false;
    });
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1280,
      );
      if (picked != null) {
        widget.logic.sendImageMessage(picked.path);
      }
    } catch (e) {
      AppToast.error('选取图片失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 分割线
        const Divider(height: 1, color: AppColors.c_E8EAEF),
        // 输入区域
        Container(
          color: AppColors.c_FFFFFF,
          padding: EdgeInsets.only(
            left: 12,
            right: 8,
            top: 8,
            bottom: (_showEmojiOptions || _showAddOptions) ? 0 : MediaQuery.of(context).padding.bottom + 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 语音/键盘切换
              _buildIconButton(
                icon: _isVoiceMode ? Icons.keyboard_rounded : Icons.mic_rounded,
                onTap: () => setState(() => _isVoiceMode = !_isVoiceMode),
              ),
              const SizedBox(width: 2),
              // 输入区域：语音模式 / 文本模式
              Expanded(
                child: _isVoiceMode ? _buildVoiceButton() : _buildTextField(),
              ),
              const SizedBox(width: 2),
              // 表情按钮
              _buildIconButton(
                icon: Icons.emoji_emotions_outlined,
                onTap: () => setState(() {
                  _showEmojiOptions = !_showEmojiOptions;
                  if (_showEmojiOptions) _showAddOptions = false;
                }),
              ),
              // 更多功能按钮
              _buildIconButton(
                icon: Icons.add_rounded,
                onTap: () => setState(() {
                  _showAddOptions = !_showAddOptions;
                  if (_showAddOptions) _showEmojiOptions = false;
                }),
              ),
            ],
          ),
        ),
        // 表情/图片选择面板（显示在输入框下方）
        if (_showEmojiOptions) _buildEmojiPanel(),
        if (_showAddOptions) _buildAddOptions(),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Icon(icon, size: 32, color: AppColors.c_8E9AB0),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      constraints: const BoxConstraints(minHeight: 40, maxHeight: 120),
      decoration: BoxDecoration(
        color: AppColors.c_F0F2F6,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLines: null,
        textInputAction: TextInputAction.send,
        onTap: () => _hidePanels(),
        onSubmitted: (_) => _sendText(),
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.c_0C1C33,
        ),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildVoiceButton() {
    return GestureDetector(
      onTapDown: (_) {
        // TODO: 开始录音
      },
      onTapUp: (_) {
        // TODO: 停止录音并发送
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.c_F0F2F6,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: const Text(
          '按住说话',
          style: TextStyle(fontSize: 15, color: AppColors.c_8E9AB0),
        ),
      ),
    );
  }

  void _hidePanels() {
    if (_showEmojiOptions || _showAddOptions) {
      setState(() {
        _showEmojiOptions = false;
        _showAddOptions = false;
      });
    }
  }

  void _insertEmoji(String emoji) {
    final text = _controller.text;
    final selection = _controller.selection;
    final start = selection.start;
    final end = selection.end;
    if (start < 0) {
      _controller.text = text + emoji;
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    } else {
      final newText = text.replaceRange(start, end, emoji);
      _controller.text = newText;
      _controller.selection = TextSelection.collapsed(offset: start + emoji.length);
    }
  }

  Widget _buildEmojiPanel() {
    const emojis = [];

    return Container(
      color: AppColors.c_FFFFFF,
      height: 200,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: emojis.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => _insertEmoji(emojis[index]),
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: Text(emojis[index], style: const TextStyle(fontSize: 24)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddOptions() {
    return Container(
      color: AppColors.c_FFFFFF,
      padding: EdgeInsets.only(
            // left: 10,
            // right: 10,
            top: 22,
            bottom: MediaQuery.of(context).padding.bottom + 8,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(child: _buildAddOption(
            icon: Icons.photo_library_rounded,
            label: '相册',
            onTap: () => _pickImage(ImageSource.gallery),
          )),
          Flexible(child: _buildAddOption(
            icon: Icons.camera_alt_rounded,
            label: '拍照',
            onTap: () => _pickImage(ImageSource.camera),
          )),
          Flexible(child: _buildAddOption(
            icon: Icons.voice_chat_rounded,
            label: '视频通话',
            onTap: () => _pickImage(ImageSource.camera),
          )),
          Flexible(child: _buildAddOption(
            icon: Icons.voice_chat,
            label: '语音通话',
            onTap: () => _pickImage(ImageSource.camera),
          )),
        ],
      ),
    );
  }

  Widget _buildAddOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.c_F0F2F6,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 28, color: AppColors.c_666666),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.c_8E9AB0,
              ),
            ),
          ],
        ),
    );
  }
}
