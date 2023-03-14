import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitList(),
    );
  }
}

class FruitList extends StatefulWidget {
  const FruitList({super.key});

  @override
  _FruitListState createState() => _FruitListState();
}

class _FruitListState extends State<FruitList> {
  List<String> fruits = [
    "Яблуко",
    "Банан",
    "Апельсин",
    "Груша",
    "Ананас",
    "Манго",
    "Ківи",
    "Персик",
    "Виноград",
    "Полуниця",
    "Чорниця",
    "Малина",
    "Кавун",
    "Диня",
    "Гранат",
    "Лимон",
    "Лайм"
  ];

  List<String> fruitsDescription = [
    "Їстівний плід яблуні, соковитий, багатий на вітаміни та мікроелементи.",
    "Їстівний фрукт, за біологічним типом — ягода, що отримується з культивованих видів роду Банан.",
    "Їстівний плід вічнозеленого дерева апельсин, гесперидій — багатогніздова ягода.",
    "Груша багата на прості цукри, особливо фруктозу. Поширеність калію робить її придатною для гіподичної дієти (тобто дієти з низьким вмістом натрію).",
    "Багаторічна рослина родини бромелієвих, найвідоміший представник однойменного роду. Харчова, технічна та декоративна культура.",
    "Плоди мають волокнисту структуру та солодкий смак, шкірка забарвлена в тони червоного, зеленого або жовтого кольорів, у м'якоті колір жовтий або помаранчевий.",
    "Молодий фрукт, що з'явився тільки в середині XIX століття в результаті окультурення актинідії приємної Actinidia deliciosa, ліани з роду актинідієвих садівником-аматором із Нової Зеландії Олександром Еллісоном.",
    "Багаторічна рослина родини розових, споріднена з мигдалем. Вельми популярна і поширена плодова культура, яку також використовують як олійну, лікарську та декоративну.",
    "Гроно винограду, плоди, що ростуть на виноградній лозі. Плоди винограду, а також продукти його переробки мають цінні лікувальні, смакові і харчові якості.",
    "Являє собою гібрид, виведений штучно від схрещування двох американських видів — суниць чилійських і суниць вірґінських. Суниці садові — одна з найпоширеніших в Україні ягідних культур.",
    "Плід — куляста чорна ягода, достигає у червні — липні. М'якоть стиглої ягоди — червонувато-фіолетова, кисло-солодка, дещо в'язка на смак та сильно забарвлює губи та зуби при її споживанні.",
    "Плід малини звичайної. За ботанічною класифікацією плід малини — не ягода, а багатокістянка.",
    "Баштанна культура родини гарбузових. Вирощується в районах з великим сонячним випромінюванням. В Україні традиційним центром виробництва баштанних культур є Херсонська область, де щорічно збирається понад 50 % урожаю кавунів у країні.",
    "Однорічна рослина з роду огірок і родини гарбузових. Харчова баштанна культура, іноді застосовується як лікарська.",
    "Деякі класифікації визначають гранат як нижню синкарпнійську коробочку. Гранат з щільним шкірястим околоплодником (перикарпієм), неправильно розтріскується при дозріванні.",
    "Плоди використовуються для кулінарних цілей, в першу чергу його сік та цедра використовуються, в основному, в кулінарії та приготуванні кондитерських виробів.",
    "Плід рослини лайм триби цитрусових родом з Індії, генетично схожий з лимоном. Іноді називають також зеленим лимоном."
  ];

  void _removeFruit(int index) {
    setState(() {
      fruits.removeAt(index);
      fruitsDescription.removeAt(index);
    });
  }

  void _editFruit(int index) {
    final TextEditingController controller = TextEditingController(text: fruits[index]);
    final TextEditingController controllerDescription = TextEditingController(text: fruitsDescription[index]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редагування фрукта'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Введіть назву фрукта'),
                ),
                TextField(
                  controller: controllerDescription,
                  decoration: const InputDecoration(hintText: 'Введіть опис фрукта'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Відміна'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Зберегти'),
              onPressed: () {
                setState(() {
                  fruits[index] = controller.text;
                  fruitsDescription[index] = controllerDescription.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit List'),
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(fruits[index]),
            onDismissed: (direction) {
              _removeFruit(index);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${fruits[index]} видалений зі списка'),
                action: SnackBarAction(
                  label: 'Відміна',
                  onPressed: () {
                    setState(() {
                      fruits.insert(index, fruits[index]);
                      fruitsDescription.insert(index, fruitsDescription[index]);
                    });
                  },
                ),
              ));
            },
            child: ListTile(
              title: Text(fruits[index]),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(fruits[index]),
                      content: Text(fruitsDescription[index]),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              onLongPress: () {
                _editFruit(index);
              },
            ),
          );
        },
      ),
    );
  }
}
