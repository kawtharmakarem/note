import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/details/cubit/details_cubit.dart';
import '/features/details/cubit/details_state.dart';
import '/features/details/presentation/components/add_blog_widget.dart';
import '/features/details/presentation/components/add_folder_widget.dart';
import '/features/details/presentation/components/add_todo_widget.dart';
import '/features/details/presentation/components/blog_content.dart';
import '/features/details/presentation/components/folder_content.dart';
import '/features/details/presentation/components/todo_content.dart';
import '/features/details/presentation/components/notes_content.dart';
import '/features/home/data/models/folder_model.dart';
import '/features/details/presentation/components/appbar_section.dart';

import '../components/add_note_widget.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.folderModel});
  final FolderModel folderModel;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _addblogKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addTodoKey = GlobalKey<FormState>();

  late AnimationController _sheetcontroller;
  @override
  void initState() {
    super.initState();
    _sheetcontroller = BottomSheet.createAnimationController(this);
    _sheetcontroller.duration = Duration(seconds: 1);
    _sheetcontroller.reverseDuration = Duration(seconds: 1);
    _sheetcontroller.drive(CurveTween(curve: Curves.easeIn));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailsCubit>().loadFolders(
        context,
        widget.folderModel.userId!,
      );
      context.read<DetailsCubit>().getAllNotes(
        widget.folderModel.folderId,
        widget.folderModel.userId,
      );
      context.read<DetailsCubit>().getAllBlogs(
        widget.folderModel.userId,
        widget.folderModel.folderId,
      );
      context.read<DetailsCubit>().getAllTodos(
        widget.folderModel.userId,
        widget.folderModel.folderId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state is InsertNoteSucces) {
            Navigator.pop(context);
          }
          if (state is DeleteNoteSuccess) {
            Navigator.pop(context);
          }
          if (state is InsertBlogSuccess) {
            Navigator.pop(context);
          }
          if (state is InsertTodoSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<DetailsCubit>();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: AppbarSection(
                    title: widget.folderModel.folderName,
                    onAdd: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        transitionAnimationController: _sheetcontroller,
                        builder: (context) {
                          return BlocProvider.value(
                            value: cubit,
                            child: addWidget(widget.folderModel),
                          );
                        },
                      );
                    },
                    onSearch: () {},
                  ),
                ),
              ),
              SliverFillRemaining(child: getWidget(widget.folderModel)),
            ],
          );
        },
      ),
    );
  }

  Widget getWidget(FolderModel folderModel) {
    switch (folderModel.folderName) {
      case "Folders":
        return FolderContent(folderModel: folderModel);
      case "Notes":
        return NotesContent();
      case "ToDo":
        return TodoContent();
      case "Blogs":
        return BlogContent();
      default:
        return SizedBox();
    }
  }

  Widget addWidget(FolderModel folderModel) {
    switch (folderModel.folderName) {
      case "Folders":
        return AddFolderWidget();
      case "Notes":
        return AddNoteWidget(folderModel: folderModel);
      case "ToDo":
        return AddTodoWidget(folderModel: folderModel);
      case "Blogs":
        return AddBlogWidget(folderModel: folderModel);
      default:
        return Container();
    }
  }
}
