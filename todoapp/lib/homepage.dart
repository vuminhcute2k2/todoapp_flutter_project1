import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

enum TodoCategory { finance, wedding, freelance, shoppingList }

class TodoItem {
  final String title;
  final TodoCategory category;
  final bool isChecked;

  TodoItem({
    required this.title,
    required this.category,
    required this.isChecked,
  });
  TodoItem copyWith({
    String? title,
    TodoCategory? category,
    bool? isChecked,
  }){
    return TodoItem(title: title ?? this.title, category: category ?? this.category, isChecked: isChecked?? this.isChecked);
  }
}

class _HomePageScreenState extends State<HomePageScreen> {
  final listIncomplete = [
    TodoItem(
      title: "Upload 1099-R to TurboTax",
      category: TodoCategory.finance,
      isChecked: false,
    ),
    TodoItem(
      title: "Print parking passes",
      category: TodoCategory.wedding,
      isChecked: false,
    ),
    TodoItem(
      title: "Sign contract, send back",
      category: TodoCategory.freelance,
      isChecked: false,
    ),
    TodoItem(
      title: "Hand sanitizer",
      category: TodoCategory.shoppingList,
      isChecked: false,
    ),
    
  ];
  final listCompleted = [];
  //xoa từng phần tử trong listIncomplete
  void deleteItem(int index){
    setState(() {
      listIncomplete.removeAt(index);
    });
  }
  //xoa tat ca 
  void deleteAll(){
    setState(() {
      listIncomplete.clear();
    });
  }

  Widget _checkBoxWidget(bool isChecked) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: const Color(0xffDADADA),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: isChecked
          ? const Icon(
              Icons.check_outlined,
              size: 14,
            )
          : const SizedBox.shrink(),
    );
  }

  IconData getIconData(TodoCategory category) {
    switch (category) {
      case TodoCategory.finance:
        return Icons.money;
      case TodoCategory.freelance:
        return Icons.work;
      case TodoCategory.shoppingList:
        return Icons.shop;
      case TodoCategory.wedding:
        return Icons.favorite;
    }
  }

  String getCategoryText(TodoCategory category) {
    switch (category) {
      case TodoCategory.finance:
        return "Finance";
      case TodoCategory.wedding:
        return "Wedding";
      case TodoCategory.freelance:
        return "Freelance";
      case TodoCategory.shoppingList:
        return "Shopping List";
    }
  }

  Widget _categoryWidget(TodoCategory category) {
    return Row(
      children: [
        Icon(
          getIconData(category),
        ),
        Text(
          " ${getCategoryText(category)}",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            height: 17 / 14,
            // Thay # bằng 0xff
            color: const Color(0xffB9B9BE),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Item
                _renderHeader(),
                _renderListInComplete(),
                const SizedBox(
                  height: 32,
                ),
                _renderListComplete(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _renderListComplete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Row(
          children: [
            Text(
              "Completed",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                // Thay # bằng 0xff
                color: const Color(0xff575767),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                // List<TodoItem> newitem = listIncomplete;
                // newitem[index]
                setState(() {
                  for(int i=0;i<listCompleted.length;i++){
                    listIncomplete.add(listCompleted[i]);
                  }
                  listCompleted.clear();
                  
              });
                },
                child: const Icon(Icons.ads_click),
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listCompleted.length,
          itemBuilder: (context, index)  => GestureDetector(
            onTap: (){
              final currentItem = listCompleted[index];
              final newItem = currentItem.copyWith(isChecked: false);
              setState(() {
                listIncomplete.add(newItem);
                listCompleted.removeAt(index);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _checkBoxWidget(true),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listCompleted[index].title,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 24 / 18,
                            color: const Color(0xffB9B9BE),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Column _renderListInComplete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Incomplete",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                // Thay # bằng 0xff
                color: const Color(0xff575767),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    deleteAll();
                  });
                },
                child: const Icon(Icons.delete_outline),
              ),
            ),
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listIncomplete.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: (){
              final currentItem = listIncomplete[index];
              final newItem = currentItem.copyWith(isChecked: true);
              setState(() {
                listIncomplete.removeAt(index);
                listCompleted.add(newItem);
              });
            },
            
            child: Container(
              margin: const EdgeInsets.only(
                top: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _checkBoxWidget(
                    listIncomplete[index].isChecked,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listIncomplete[index].title,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 24 / 18,
                            color: const Color(0xff575767),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 4),
                          child: _categoryWidget(
                            listIncomplete[index].category,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(onTap: () {
                                deleteItem(index);
                              }, child: const Icon(Icons.delete)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Column _renderHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 48, bottom: 8),
          child: Text(
            DateFormat("MMMM d, yyyy").format(DateTime.now()).toString(),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 32,
              // height = lineHeight / fontSize
              height: 39 / 32,
              // Thay # bằng 0xff
              color: const Color(0xff0E0E11),
            ),
          ),
        ),
        Text(
          "${listIncomplete.length} incomplete, ${listCompleted.length} completed",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            // height = lineHeight / fontSize
            height: 17 / 14,
            // Thay # bằng 0xff
            color: const Color(0xff575767),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: const Divider(
            color: Color(0xffD0D0D0),
          ),
        )
      ],
    );
  }
}
