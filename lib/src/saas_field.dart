import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SaasField extends StatefulWidget {
  SaasField({
    super.key,
    this.height = 50,
    this.boxShadow = const [],
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.items = const [],
    this.prefixIcon,
    this.actions = const [],
    this.padding = const EdgeInsets.all(8),
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    TextEditingController? controller,
    this.textInputAction = TextInputAction.search,
    this.showDivider = false,
    this.elevation = 0.1,
  })  : assert(items.isNotEmpty, "items can't be empty"),
        assert(elevation >= 0, "elevation can't be negative"),
        assert(height > 0, "height can't be negative"),
        assert(elevation <= 1, "elevation can't be greater than 1"),
        controller = controller ?? TextEditingController();

  final double height;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final List<dynamic> items;
  final Widget? prefixIcon;
  final List<Widget> actions;
  final EdgeInsetsGeometry padding;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  final bool showDivider;
  final double elevation;

  @override
  State<SaasField> createState() => _SaasFieldState();
}

class _SaasFieldState extends State<SaasField> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  ValueNotifier<dynamic> child1 = ValueNotifier(null);
  ValueNotifier<dynamic> child2 = ValueNotifier(null);

  Duration duration = 1500.ms;
  Duration delayDuration = 500.ms;
  List<BoxShadow> boxShadow = [];
  List<dynamic> list = [];

  late TextEditingController textEditingController;
  ValueNotifier<bool> isTyping = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(vsync: this, duration: duration);
    controller2 = AnimationController(vsync: this, duration: duration);
    textEditingController = widget.controller
      ..addListener(
          () => isTyping.value = textEditingController.text.isNotEmpty);
    init();
  }

  void init() {
    if (widget.items.isEmpty) return;
    list = widget.items;

    child1.value = list.first;
    child2.value = list[1];

    controller1.forward().whenComplete(() => controller2.forward());
    controller1.addListener(() async {
      if (controller1.isCompleted) {
        child1.value = child2.value;
        controller1.reset();
        await Future.delayed(duration);
        controller1.forward();
      }
      setState(() {});
    });

    controller2.addListener(
      () async {
        if (controller2.isCompleted) {
          int index = list.indexOf(child2.value);
          if (index == list.length - 1) {
            child2.value = list.first;
          } else {
            child2.value = list[index + 1];
          }
          controller2.reset();
          await Future.delayed(duration);

          controller2.forward();
        }
        setState(() {});
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (boxShadow.isEmpty) {
        boxShadow = [
          BoxShadow(
            color: Colors.grey.withOpacity(widget.elevation),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ];
        boxShadow.addAll(widget.boxShadow);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).hintColor, fontWeight: FontWeight.w500);
    return LayoutBuilder(
      builder: (context, b) {
        return Container(
          margin: boxShadow.isNotEmpty
              ? EdgeInsetsDirectional.only(
                  start: b.maxWidth * 0.005, end: b.maxWidth * 0.005)
              : null,
          height: widget.height,
          width: b.maxWidth,
          decoration: BoxDecoration(
            boxShadow: boxShadow,
            borderRadius: widget.borderRadius,
            color: Theme.of(context).cardColor,
          ),
          child: LayoutBuilder(builder: (context, innerB) {
            return ClipRRect(
              borderRadius: widget.borderRadius,
              child: Row(
                children: [
                  if (widget.prefixIcon != null)
                    SizedBox(
                        height: innerB.maxHeight, child: widget.prefixIcon!),
                  buildMiddle(innerB, textStyle),
                  if (widget.actions.isNotEmpty && widget.showDivider)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.padding.vertical - 2),
                      child: VerticalDivider(
                        color: Colors.grey[600],
                        thickness: 1.5,
                      ),
                    ),

                  ///clear
                  ValueListenableBuilder(
                    valueListenable: isTyping,
                    builder: (context, typing, __) {
                      return typing
                          ? InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(CupertinoIcons.clear_circled_solid),
                              ),
                              onTap: () {
                                textEditingController.clear();
                                isTyping.value = false;
                              },
                            )
                              .animate()
                              .fade(
                                duration: 100.ms,
                                begin: 0,
                                end: 1,
                              )
                              .scale(
                                duration: 100.ms,
                                begin: const Offset(0.8, 0.8),
                                end: const Offset(1, 1),
                              )
                          : const SizedBox.shrink();
                    },
                  ),

                  SizedBox(
                    height: innerB.maxHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: widget.actions,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget buildMiddle(BoxConstraints innerB, TextStyle? textStyle) {
    return ValueListenableBuilder(
        valueListenable: isTyping,
        builder: (context, typing, __) {
          return Expanded(
            child: Container(
              // color: Colors.amber,
              padding: const EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.centerLeft,
              height: innerB.maxHeight,
              child: Stack(
                children: [
                  /// bg
                  AnimatedOpacity(
                    opacity: list.isNotEmpty && !typing ? 1 : 0,
                    duration: 100.ms,
                    child: IntrinsicHeight(
                      child: AnimatedBuilder(
                          animation: controller1,
                          builder: (context, _) {
                            return AnimatedBuilder(
                                animation: controller2,
                                builder: (context, _) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Container(height: innerB.maxHeight),
                                      firstWidget(textStyle),
                                      secondWidget(textStyle),
                                    ],
                                  );
                                });
                          }),
                    ),
                  ),

                  /// textfield
                  TextFormField(
                    controller: textEditingController,
                    onTap: widget.onTap,
                    onChanged: widget.onChanged,
                    onFieldSubmitted: widget.onSubmitted,
                    readOnly: widget.readOnly,
                    textInputAction: widget.textInputAction,
                    // textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: textStyle,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget firstWidget(TextStyle? textStyle) {
    return ValueListenableBuilder(
            valueListenable: child1,
            builder: (context, ch, __) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ch.toString(),
                  // textAlign: TextAlign.center,
                  style: textStyle,
                )
                    .animate(
                      controller: controller1,
                      // autoPlay: true,
                    )
                    .fade(
                      duration: duration,
                      // delay: delayDuration,
                      end: 0.4,
                      begin: 1,
                    )
                    .moveY(
                      // delay: delayDuration,
                      duration: duration,
                      begin: 0,
                      end: -100,
                    ),
              );
            })
        // .scale(
        //   end: const Offset(0.8, 0.8),
        //   begin: const Offset(1.5, 1.5),
        // )
        ;
  }

  Widget secondWidget(TextStyle? textStyle) {
    return ValueListenableBuilder(
            valueListenable: child2,
            builder: (context, ch, __) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ch.toString(),
                  // textAlign: TextAlign.center,
                  style: textStyle,
                )
                    .animate(
                      controller: controller2,
                      // autoPlay: true,
                    )
                    .fade(
                      duration: duration,
                      // delay: delayDuration,
                      begin: 0.6,
                      end: 1,
                    )
                    .moveY(
                      // delay: delayDuration,
                      duration: duration,
                      begin: 100,
                      end: 0,
                    ),
              );
            })
        // .scale(
        //   begin: const Offset(0.8, 0.8),
        //   end: const Offset(1.5, 1.5),
        // )
        ;
  }
}
