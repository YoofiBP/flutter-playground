import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DownloadStatus { notDownloaded, fetchingDownload, downloading, downloaded }

class DownloadButton extends StatefulWidget {
  const DownloadButton(
      {Key? key,
      required this.onDownload,
      required this.onCancel,
      required this.onOpen,
      required this.downloadStatus,
      this.progress = 0.0,
      this.transitionDuration = const Duration(milliseconds: 500)})
      : super(key: key);

  final DownloadStatus downloadStatus;
  final Duration transitionDuration;
  final double progress;
  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback onOpen;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  void onPressed() {
    switch (widget.downloadStatus) {
      case DownloadStatus.downloaded:
        widget.onOpen();
        break;
      case DownloadStatus.downloading:
        widget.onCancel();
        break;
      case DownloadStatus.fetchingDownload:
        break;
      case DownloadStatus.notDownloaded:
        widget.onDownload();
        break;
    }
  }

  bool get _isDownloading =>
      widget.downloadStatus == DownloadStatus.downloading;

  bool get _isFetching =>
      widget.downloadStatus == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => widget.downloadStatus == DownloadStatus.downloaded;

  Widget _buildButtonShape({required Widget child}) => AnimatedContainer(
        duration: widget.transitionDuration,
        curve: Curves.ease,
        width: double.infinity,
        decoration: _isDownloading || _isFetching
            ? ShapeDecoration(
                shape: const CircleBorder(),
                color: Colors.white.withOpacity(0.0))
            : ShapeDecoration(
                shape: StadiumBorder(),
                color: CupertinoColors.lightBackgroundGray),
        child: child,
      );

  Widget _buildText() {
    final text = _isDownloaded ? 'OPEN' : 'GET';
    final opacity = _isDownloading || _isFetching ? 0.0 : 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedOpacity(
        duration: widget.transitionDuration,
        opacity: opacity,
        curve: Curves.ease,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button?.copyWith(
              fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() => AspectRatio(
        aspectRatio: 1.0,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: widget.progress),
          duration: const Duration(milliseconds: 500),
          builder: (context, progress, child) => CircularProgressIndicator(
            backgroundColor: _isDownloading
                ? CupertinoColors.lightBackgroundGray
                : Colors.white.withOpacity(0),
            valueColor: AlwaysStoppedAnimation(_isFetching
                ? CupertinoColors.lightBackgroundGray
                : CupertinoColors.activeBlue),
            strokeWidth: 2.0,
            value: _isFetching ? null : progress,
          ),
        ),
      );

  Widget _buildDownloadingProgress() => Positioned.fill(
          child: AnimatedOpacity(
        opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
        duration: widget.transitionDuration,
        curve: Curves.ease,
        child: Stack(children: [
          _buildProgressIndicator(),
          Icon(Icons.stop, size: 14, color: CupertinoColors.activeBlue)
        ]),
      ));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(children: [
        _buildButtonShape(child: _buildText()),
        _buildDownloadingProgress()
      ]),
    );
  }
}
