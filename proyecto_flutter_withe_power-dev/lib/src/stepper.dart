import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double MARGIN_NORMAL = 16;
const double CHIP_BORDER_RADIUS = 30;
const double MARGIN_SMALL = 8;
const double PADDING_SMALL = 8;

enum HorizontalStepState { SELECTED, UNSELECTED }

enum Type { TOP, BOTTOM }

class HorizontalStep {
  final String title;
  final Widget widget;
  bool isValid;
  HorizontalStepState state;

  HorizontalStep({
    required this.title,
    required this.widget,
    this.state = HorizontalStepState.UNSELECTED,
    required this.isValid,
  });
}

class HorizontalStepper extends StatefulWidget {
  final List<HorizontalStep> steps;
  final Color selectedColor;
  final double circleRadius;
  final Color unSelectedColor;
  final Color selectedOuterCircleColor;
  final TextStyle? textStyle;
  final Color leftBtnColor;
  final Color rightBtnColor;
  final Type type;
  final VoidCallback onComplete;
  final Color? btnTextColor;

  HorizontalStepper({
    required this.steps,
    required this.selectedColor,
    required this.circleRadius,
    required this.unSelectedColor,
    required this.selectedOuterCircleColor,
    this.textStyle,
    this.type = Type.TOP,
    required this.leftBtnColor,
    required this.rightBtnColor,
    this.btnTextColor,
    required this.onComplete,
  });

  @override
  State<StatefulWidget> createState() => _HorizontalStepperState(
        steps: this.steps,
        selectedColor: selectedColor,
        unSelectedColor: unSelectedColor,
        circleRadius: circleRadius,
        selectedOuterCircleColor: selectedOuterCircleColor,
        textStyle: textStyle!,
        type: type,
        leftBtnColor: leftBtnColor,
        rightBtnColor: rightBtnColor,
        onComplete: onComplete,
        btnTextColor: btnTextColor,
      );
}

class _HorizontalStepperState extends State<StatefulWidget> {
  final List<HorizontalStep> steps;
  final Color selectedColor;
  final Color unSelectedColor;
  final double circleRadius;
  final TextStyle? textStyle;
  final Type type;
  final Color leftBtnColor;
  final Color rightBtnColor;
  final VoidCallback onComplete;
  final Color? btnTextColor;

  Color selectedOuterCircleColor;
  PageController? _controller;
  int currentStep = 0;

  _HorizontalStepperState({
    required this.steps,
    required this.selectedColor,
    required this.circleRadius,
    required this.unSelectedColor,
    required this.selectedOuterCircleColor,
    this.textStyle,
    required this.type,
    required this.leftBtnColor,
    required this.rightBtnColor,
    required this.onComplete,
    this.btnTextColor,
  });

  @override
  void initState() {
    _controller = PageController();
    _controller!.addListener(() {
      if (!steps[currentStep].isValid) {
        _controller!.jumpToPage(currentStep);
      }
    });
    super.initState();
  }

  void changeStatus(int index) {
    if (isForward(index)) {
      markAsCompletedForPrecedingSteps();
    } else {
      markAsUnselectedToSucceedingSteps();
    }
    setState(() {
      currentStep = index;
      steps[index].state = HorizontalStepState.SELECTED;
    });
  }

  void markAsUnselectedToSucceedingSteps() {
    for (int i = steps.length - 1; i >= currentStep; i--) {
      steps[i].state = HorizontalStepState.UNSELECTED;
    }
  }

  void markAsCompletedForPrecedingSteps() {
    for (int i = 0; i <= currentStep; i++) {
      steps[i].state = HorizontalStepState.SELECTED;
    }
  }

  bool _isLast(int index) {
    return steps.length - 1 == index;
  }

  void _goToNextPage() {
    if (_isLast(currentStep)) {
      onComplete.call();
    }
    if (currentStep < steps.length - 1) {
      currentStep++;
      setState(() {});
      _controller!.jumpToPage(currentStep);
    }
  }

  void _goToPreviousPage() {
    if (currentStep > 0) {
      currentStep--;
      _controller!.jumpToPage(currentStep);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: type == Type.TOP
          ? _getTopTypeWidget(width)
          : _getBottomTypeWidget(width),
    );
  }

  List<Widget> _getBottomTypeWidget(double width) {
    return [
      _getPageWidgets(),
      _getIndicatorWidgets(width),
      SizedBox(
        height: MARGIN_SMALL,
      ),
      _getTitleWidgets(),
      _getButtons()
    ];
  }

  Widget _getPageWidgets() {
    return Expanded(
      child: PageView(
        controller: _controller,
        onPageChanged: (index) => setState(() {
          changeStatus(index);
        }),
        children: _getPages(),
      ),
    );
  }

  Widget _getTitleWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: getTitles(),
    );
  }

  Widget _getIndicatorWidgets(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: PADDING_SMALL,
      ),
      child: Container(
          child: Column(
        children: <Widget>[
          Row(
            children: _getStepCircles(currentStep),
          )
        ],
      )),
    );
  }

  List<Widget> _getTopTypeWidget(double width) {
    return [
      _getIndicatorWidgets(width),
      SizedBox(
        height: MARGIN_SMALL,
      ),
      _getTitleWidgets(),
      _getPageWidgets(),
      _getButtons()
    ];
  }

  Widget _getButtons() {
    return Container(
      padding: const EdgeInsets.all(
        MARGIN_NORMAL,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () => _goToPreviousPage(),
              child: Container(
                padding: const EdgeInsets.all(
                  MARGIN_NORMAL,
                ),
                child: Center(
                  child: Text(
                    "Atras",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: btnTextColor ?? Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: leftBtnColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      CHIP_BORDER_RADIUS,
                    ),
                    topLeft: Radius.circular(
                      CHIP_BORDER_RADIUS,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => steps[currentStep].isValid ? _goToNextPage() : null,
              child: Container(
                padding: const EdgeInsets.all(
                  MARGIN_NORMAL,
                ),
                child: currentStep == 2
                    ? Center(
                        child: Text(
                          "Confirmar",
                          style: TextStyle(
                            fontSize: 14,
                            color: btnTextColor ?? Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Center(
                        child: Text(
                          "Siguiente",
                          style: TextStyle(
                            fontSize: 14,
                            color: btnTextColor ?? Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                decoration: BoxDecoration(
                  color:
                      steps[currentStep].isValid ? rightBtnColor : Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                      CHIP_BORDER_RADIUS,
                    ),
                    topRight: Radius.circular(
                      CHIP_BORDER_RADIUS,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getTitles() {
    return steps
        .map((e) => Flexible(
              child: Text(
                e.title,
                maxLines: 2,
                style: textStyle ??
                    const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ))
        .toList();
  }

  List<Widget> _getStepCircles(int current) {
    List<Widget> widgets = [];
    steps.asMap().forEach((key, value) {
      widgets.add(_StepCircle(value, circleRadius, selectedColor,
          unSelectedColor, selectedOuterCircleColor, key + 1));
      if (key != steps.length - 1) {
        widgets.add(_StepLine(
          steps[key + 1],
          selectedColor,
          unSelectedColor,
        ));
      }
    });
    return widgets;
  }

  List<Widget> _getPages() {
    return steps.map((e) => e.widget).toList();
  }

  bool isForward(int index) {
    return index > currentStep;
  }
}

class _StepLine extends StatelessWidget {
  final HorizontalStep step;
  final Color selectedColor;
  final Color unSelectedColor;

  _StepLine(
    this.step,
    this.selectedColor,
    this.unSelectedColor,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(
        left: 4,
        right: 4,
      ),
      height: 2,
      color: step.state == HorizontalStepState.SELECTED
          ? selectedColor
          : unSelectedColor,
    ));
  }
}

class _StepCircle extends StatelessWidget {
  final HorizontalStep step;
  final double circleRadius;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color selectedOuterCircleColor;
  final int currentStepOption;

  _StepCircle(
    this.step,
    this.circleRadius,
    this.selectedColor,
    this.unSelectedColor,
    this.selectedOuterCircleColor,
    this.currentStepOption,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleRadius,
      width: circleRadius,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: _getColor(),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(circleRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          4,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: step.state == HorizontalStepState.SELECTED
                ? selectedColor
                : unSelectedColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                circleRadius,
              ),
            ),
          ),
          child: Center(
              child: Text(
            "$currentStepOption",
            style: GoogleFonts.openSans(color: Colors.white),
          )),
        ),
      ),
    );
  }

  Color _getColor() {
    if (step.state == HorizontalStepState.SELECTED) {
      return selectedOuterCircleColor != null
          ? selectedOuterCircleColor
          : selectedColor;
    }
    return unSelectedColor;
  }
}
