// import 'package:farmgate/src/model/register/type_user.dart';
// import 'package:farmgate/src/screens/register/cubit/register_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:simplest/simplest.dart';

// class SelectTypeUserDropDown extends CubitWidget<RegisterCubit, RegisterState> {
//   SelectTypeUserDropDown({
//     this.size,
//     this.padding,
//   });

//   final Size size;
//   final double padding;

//   final List<TypeUser> listTypeUsers = [
//     TypeUser(value: 1, name: 'merchant'),
//   ];

//   @override
//   Widget builder(BuildContext context, state) {
//     return Container(
//       margin: EdgeInsets.only(top: 0.0, bottom: padding / 2),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text.rich(
//             TextSpan(children: [
//               TextSpan(
//                   text: 'user_type'.tr, style: TextStyle(color: Colors.grey)),
//               TextSpan(text: '*', style: TextStyle(color: Colors.redAccent))
//             ]),
//           ),
//           Container(
//             width: size.width,
//             padding: EdgeInsets.only(left: padding / 4),
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.all(Radius.circular(5.0))),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     focusedErrorBorder: InputBorder.none,
//                   ),
//                   hint: Text('select_user_type'.tr),
//                   items: listTypeUsers.map((e) {
//                     return DropdownMenuItem(
//                       child: Text(e.name.tr),
//                       value: e.value,
//                     );
//                   }).toList(),
//                   validator: (value) =>
//                       value == null ? 'please_select_type_user'.tr : null,
//                   onChanged: (value) {
//                     context.read<RegisterCubit>().changeTypeUser(listTypeUsers[
//                         listTypeUsers
//                             .indexWhere((element) => element.value == value)]);
//                   }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
