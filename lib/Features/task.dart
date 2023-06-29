import 'package:crud_app/Data/data_provider.dart';
import 'package:crud_app/Data/responsitory.dart';
import 'package:crud_app/Domain/task_model.dart';
import 'package:crud_app/Features/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TeamWidget extends ConsumerStatefulWidget {
  const TeamWidget({super.key});

  @override
  ConsumerState<TeamWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<TeamWidget> {
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    final TextEditingController addteamcontroller = TextEditingController();
    final TextEditingController editteamcontroller = TextEditingController();
    final data = ref.watch(getProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Center(
              child: Text('Collecting Team Group',
                  style: TextStyle(color: Colors.white))),
        ),
        body: data.when(
            data: (data) {
              List<Task> result = data.map((e) => e).toList();
              print(result.length);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 620,
                      child: ListView.builder(
                          itemCount: result.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Column(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Team ${result[index].id!.toString()} ',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child:
                                                    Text(result[index].title!,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ))),
                                            InkWell(
                                                onTap: () {
                                                  ref
                                                      .watch(getTaskProvider)
                                                      .editTask(data[index])
                                                      .then((value) async {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            'Message'),
                                                        content: TextField(
                                                            controller:
                                                                editteamcontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  data[index]
                                                                      .title,
                                                            )),
                                                        actions: [
                                                          InkWell(
                                                              onTap: () {
                                                                print('edit');
                                                                data[index]
                                                                        .title =
                                                                    editteamcontroller
                                                                        .text;
                                                                Navigator.pop(
                                                                    context);
                                                                print(
                                                                    data[index]
                                                                        .title);
                                                                setState(() {});
                                                              },
                                                              child: const ButtonBoxWidget(
                                                                  iconphoto:
                                                                      Icons
                                                                          .edit))
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: const ButtonBoxWidget(
                                                    iconphoto: Icons.edit)),
                                            const SizedBox(width: 20),
                                            InkWell(
                                              onTap: () {
                                                ref
                                                    .watch(getTaskProvider)
                                                    .deleteTask(data[index])
                                                    .then((value) {
                                                  data.removeWhere((element) =>
                                                      element.id ==
                                                      data[index].id);

                                                  print(data[index]
                                                      .id
                                                      .toString());
                                                  setState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  3000),
                                                          content: Text(
                                                              'This Team is deleted')));
                                                });
                                              },
                                              child: const ButtonBoxWidget(
                                                iconphoto: Icons.delete_outline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: FloatingActionButton(
                          onPressed: () {
                            ref
                                .watch(getTaskProvider)
                                .addTask(Task(
                                    userId: 101,
                                    id: 101,
                                    title: 'Add Job 1',
                                    body: 'owojmohw woijfopwujjowjeojfoe'))
                                .then((value) async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(milliseconds: 3000),
                                      content: Text('This Team is added')));
                            });
                            setState(() {});
                          },
                          child: const Icon(Icons.add)),
                    )
                  ],
                ),
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
