// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:js_shared/variance.dart';

import '../common/elements.dart';
import '../elements/entities.dart';
import '../elements/types.dart';
import '../ordered_typeset.dart';
import 'element_map.dart';

/// Support for subtype checks of kernel based [DartType]s.
class KernelDartTypes extends DartTypes {
  final IrToElementMap elementMap;

  KernelDartTypes(this.elementMap);

  @override
  InterfaceType getThisType(ClassEntity cls) {
    return elementMap.getThisType(cls);
  }

  @override
  InterfaceType? getSupertype(ClassEntity cls) {
    return elementMap.getSuperType(cls);
  }

  @override
  Iterable<InterfaceType> getSupertypes(ClassEntity cls) {
    return elementMap.getOrderedTypeSet(cls).supertypes ?? const [];
  }

  @override
  Iterable<InterfaceType> getInterfaces(ClassEntity cls) {
    return elementMap.getInterfaces(cls);
  }

  @override
  InterfaceType? asInstanceOf(InterfaceType type, ClassEntity cls) {
    return elementMap.asInstanceOf(type, cls);
  }

  @override
  DartType substByContext(DartType base, InterfaceType context) {
    return elementMap.substByContext(base, context);
  }

  @override
  FunctionType? getCallType(InterfaceType type) => elementMap.getCallType(type);

  @override
  void checkTypeVariableBounds<T>(
    T context,
    List<DartType> typeArguments,
    List<DartType> typeVariables,
    void Function(
      T context,
      DartType typeArgument,
      TypeVariableType typeVariable,
      DartType bound,
    )
    checkTypeVariableBound,
  ) {
    assert(typeVariables.length == typeArguments.length);
    for (int index = 0; index < typeArguments.length; index++) {
      DartType typeArgument = typeArguments[index];
      final typeVariable = typeVariables[index] as TypeVariableType;
      DartType bound = subst(
        typeArguments,
        typeVariables,
        elementMap.getTypeVariableBound(typeVariable.element),
      );
      checkTypeVariableBound(context, typeArgument, typeVariable, bound);
    }
  }

  @override
  CommonElements get commonElements => elementMap.commonElements;

  @override
  DartType getTypeVariableBound(TypeVariableEntity element) {
    return elementMap.getTypeVariableBound(element);
  }

  @override
  List<Variance> getTypeVariableVariances(ClassEntity cls) =>
      elementMap.getTypeVariableVariances(cls);
}

class KernelOrderedTypeSetBuilder extends OrderedTypeSetBuilderBase {
  final IrToElementMap elementMap;

  KernelOrderedTypeSetBuilder(this.elementMap, ClassEntity cls) : super(cls);

  @override
  InterfaceType getThisType(ClassEntity cls) {
    return elementMap.getThisType(cls);
  }

  @override
  InterfaceType substByContext(InterfaceType type, InterfaceType context) {
    return elementMap.substByContext(type, context) as InterfaceType;
  }

  @override
  int getHierarchyDepth(ClassEntity cls) {
    return elementMap.getHierarchyDepth(cls);
  }

  @override
  OrderedTypeSet getOrderedTypeSet(ClassEntity cls) {
    return elementMap.getOrderedTypeSet(cls);
  }
}
