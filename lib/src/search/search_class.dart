import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


Future<T> mostrarBuscador<T>({
  @required BuildContext context,
  @required SearchDelegate<T> delegate,
  String query = '',
}){
  assert(delegate != null);
  assert(context != null);
  delegate.query = query ?? delegate.query;
  delegate._currentBody = _SearchBody.suggestions;
  return Navigator.of(context).push(_SearchPageRoute<T>(
    delegate: delegate,
  ));

}

abstract class SearchDelegate<T>{
  SearchDelegate({
    this.searchFieldLabel,
    this.keyboardType,
    this.textInputAction = TextInputAction.search,
  });

  Widget buildSuggestions(BuildContext context);
  Widget buildResults(BuildContext context);
  Widget buildLeading(BuildContext context);
  List<Widget> buildActions(BuildContext context);
  ThemeData appBarTheme(BuildContext context){
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  String get query => _queryTextController.text;
  set query(String value){
    assert(query != null);
    _queryTextController.text = value;

  }

  void showResults(BuildContext context){
    _focusNode?.unfocus();
    _currentBody = _SearchBody.results;
  }

  void showSuggestions(BuildContext context){
    assert(_focusNode != null, '_focusNode must be set by route before showSuggestions is called.');
    _focusNode.hasFocus;//requestFocus
    _currentBody = _SearchBody.suggestions;
  }

  void close(BuildContext context, T result){
    _currentBody = null;
    _focusNode?.unfocus();
    Navigator.of(context)
      ..popUntil((Route<dynamic> route) => route == _route)
      ..pop(result);
  }

  final String searchFieldLabel;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  Animation<double> get transitionAnimation => _proxyAnimation;

  FocusNode _focusNode;

  final TextEditingController _queryTextController = TextEditingController();

  final ProxyAnimation _proxyAnimation = ProxyAnimation(kAlwaysDismissedAnimation);

  final ValueNotifier<_SearchBody> _currentBodyNotifier = ValueNotifier<_SearchBody>(null);

  _SearchBody get _currentBody => _currentBodyNotifier.value;

  set _currentBody(_SearchBody value) {
    _currentBodyNotifier.value = value;
  }

  _SearchPageRoute<T> _route;


}

enum _SearchBody{
  suggestions,
  results,
}

class _SearchPageRoute<T> extends PageRoute<T>{
  _SearchPageRoute({
    @required this.delegate,
  }): assert(delegate != null){
    assert(
      delegate._route == null,

    );
    delegate._route = this;
  }

  final SearchDelegate<T> delegate;

  @override
  Color get barrierColor => null;
  @override
  String get barrierLabel => null;
  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
  @override
  bool get maintainState => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ){
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Animation<double> createAnimation() {
    final Animation<double> animation = super.createAnimation();
    delegate._proxyAnimation.parent = animation;
    return animation;
  }
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ){
    return _SearchPage<T>(
      delegate: delegate,
      animation: animation,
    );
  }
  @override
  void didComplete(T result) {
    super.didComplete(result);
    assert(delegate._route == this);
    delegate._route = null;
    delegate._currentBody = null;
  }

}

class _SearchPage<T> extends StatefulWidget{

   const _SearchPage({
    this.delegate,
    this.animation,
  });

  final SearchDelegate<T> delegate;
  final Animation<double> animation;

  @override
  State<StatefulWidget> createState() => _SearchPageState<T>();

}

class _SearchPageState<T> extends State<_SearchPage<T>> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    widget.delegate._queryTextController.addListener(_onQueryChanged);
    widget.animation.addStatusListener(_onAnimationStatusChanged);
    widget.delegate._currentBodyNotifier.addListener(_onSearchBodyChanged);
    focusNode.addListener(_onFocusChanged);
    widget.delegate._focusNode = focusNode;
  }
  @override
  void dispose() {
    super.dispose();
    widget.delegate._queryTextController.removeListener(_onQueryChanged);
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    widget.delegate._currentBodyNotifier.removeListener(_onSearchBodyChanged);
    widget.delegate._focusNode = null;
    focusNode.dispose();
  }
  void _onAnimationStatusChanged(AnimationStatus status){
    if (status != AnimationStatus.completed){
      return;
    }
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    if (widget.delegate._currentBody == _SearchBody.suggestions){
      focusNode.hasFocus;//requestFocus
    }
  }

  @override
  void didUpdateWidget(_SearchPage<T> oldWidget){
    super.didUpdateWidget(oldWidget);
    if (widget.delegate != oldWidget.delegate){
      oldWidget.delegate._queryTextController.removeListener(_onQueryChanged);
      widget.delegate._queryTextController.addListener(_onQueryChanged);
      oldWidget.delegate._currentBodyNotifier.removeListener(_onSearchBodyChanged);
      widget.delegate._currentBodyNotifier.addListener(_onSearchBodyChanged);
      oldWidget.delegate._focusNode = null;
      widget.delegate._focusNode = focusNode;
    }
  }

  void _onFocusChanged(){
    if (focusNode.hasFocus && widget.delegate._currentBody != _SearchBody.suggestions){
      widget.delegate.showSuggestions(context);
    }
  }
  void _onQueryChanged(){
    setState(() {
      // rebuild ourselves because query changed.
    });
  }
  void _onSearchBodyChanged() {
    setState(() {
      // rebuild ourselves because search body changed.
    });
  }
  @override
  Widget build(BuildContext context){
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = widget.delegate.appBarTheme(context);
    final String searchFieldLabel = widget.delegate.searchFieldLabel
      ?? MaterialLocalizations.of(context).searchFieldLabel;
    Widget body;
    switch(widget.delegate._currentBody){
      case _SearchBody.suggestions:
        body = KeyedSubtree(
          key: const ValueKey<_SearchBody>(_SearchBody.suggestions),
          child: widget.delegate.buildSuggestions(context),
        );
        break;
      case _SearchBody.results:
        body = KeyedSubtree(
          key: const ValueKey<_SearchBody>(_SearchBody.results),
          child: widget.delegate.buildResults(context),
        );
        break;
      
    }
    String routeName;
    switch (defaultTargetPlatform){
      case TargetPlatform.iOS:
        routeName = '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        routeName = searchFieldLabel;
      
    }
    return Semantics(
      explicitChildNodes: true,
      scopesRoute: true,
      namesRoute: true,
      label: routeName,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          iconTheme: theme.primaryIconTheme,
          textTheme: theme.primaryTextTheme,
          brightness: theme.primaryColorBrightness,
          leading: widget.delegate.buildLeading(context),
          title: TextField(
            controller: widget.delegate._queryTextController,
            focusNode: focusNode,
            style: theme.textTheme.title,
            textInputAction: widget.delegate.textInputAction,
            keyboardType: widget.delegate.keyboardType,
            onSubmitted: (String _){
              widget.delegate.showResults(context);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: searchFieldLabel,
              hintStyle: theme.inputDecorationTheme.hintStyle,
            )
          ),
          actions: widget.delegate.buildActions(context),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: body,
        )
      ),
    );
  }
}