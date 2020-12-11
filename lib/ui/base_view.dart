import 'package:appetizer/locator.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;
  final Function(T) onModelDestroy;
  final Function(Widget, T) onDidUpdateWidget;
  final Function(T) onDidChangeDependencies;

  BaseView({
    this.builder,
    this.onModelReady,
    this.onModelDestroy,
    this.onDidUpdateWidget,
    this.onDidChangeDependencies,
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.onDidChangeDependencies != null) {
      widget.onDidChangeDependencies(model);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    if (widget.onDidUpdateWidget != null) {
      widget.onDidUpdateWidget(oldWidget, model);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.onModelDestroy != null) {
      widget.onModelDestroy(model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
