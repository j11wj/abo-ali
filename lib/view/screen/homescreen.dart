import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ammar/models/location_servise.dart';
import 'package:ammar/view/widgets/DropDownButtonWidget.dart';

import 'package:ammar/view/widgets/textfieldwidget.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:mgrs_dart/mgrs_dart.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? y, x;

  File? Pledge;
  File? image1;
  File? Form;
  File? IdentityInterface;
  File? IdentityBackground;
  File? CardInterface;
  File? CardBackground;
  File? Other;

  List<String> department = [
    'قسم التقنيات والمعلوماتية بابل',
    'قسم استخبارات الحلة',
    'قسم استخبارات الكفل',
    'قسم استخبارات كوثى',
    'قسم استخبارات القاسم',
    'قسم استخبارات الهاشمية',
    'قسم استخبارات المحاويل',
    'قسم استخبارات  المسيب',
  ];
  String? mgrs;
  @override
  void initState() {
    super.initState();
  }

  TextEditingController tradeName = TextEditingController();
  TextEditingController locationType = TextEditingController();
  TextEditingController nameOfTheSiteOwner = TextEditingController();
  TextEditingController cameraType = TextEditingController();
  TextEditingController numberOfCamera = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController nameOFTheInventoryHolder = TextEditingController();
  TextEditingController inventorySide = TextEditingController();
  TextEditingController locationXandY = TextEditingController();
  TextEditingController locationMGRS = TextEditingController();
  TextEditingController inventorydate = TextEditingController();
  TextEditingController note = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String date =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                    style: TextStyle(fontSize: 20, color: Colors.blue[700]),
                    'وكالة الوزارة لشؤون الاستخبارات/     مديرية التقنيات و المعلوماتية/              قسم التقنيات والمعلوماتيه بابل/ الاستخبارت المكانية GSI'),
              ),
              TextFieldWidget(
                hint: 'الاسم التجاري',
                controller: tradeName,
                readOnly: false,
                isNote: false,
                textInputType: TextInputType.text,
              ),
              TextFieldWidget(
                hint: 'نوع الموقع',
                isNote: false,
                controller: locationType,
                readOnly: false,
                textInputType: TextInputType.text,
              ),
              TextFieldWidget(
                hint: 'اسم صاحب الموقع',
                controller: nameOfTheSiteOwner,
                readOnly: false,
                isNote: false,
                textInputType: TextInputType.text,
              ),
              TextFieldWidget(
                isNote: false,
                hint: 'نوع الكامرات',
                controller: cameraType,
                readOnly: false,
                textInputType: TextInputType.text,
              ),
              TextFieldWidget(
                hint: 'عدد الكامرات',
                controller: numberOfCamera,
                isNote: false,
                readOnly: false,
                textInputType: TextInputType.number,
              ),
              TextFieldWidget(
                hint: 'رقم الموبايل',
                controller: mobileNumber,
                isNote: false,
                readOnly: false,
                textInputType: TextInputType.phone,
              ),
              TextFieldWidget(
                hint: 'اسم القائم بالجرد',
                controller: nameOFTheInventoryHolder,
                isNote: false,
                readOnly: false,
                textInputType: TextInputType.text,
              ),
              DropDownButtonWidget(
                list: department,
                hint: 'جهت الجرد',
              ),
              TextFieldWidget(
                hint: 'الاحداثي x=$x,y=$y',
                controller: locationXandY,
                isNote: false,
                readOnly: true,
                textInputType: TextInputType.text,
              ),
              TextFieldWidget(
                hint: 'الاحداثي MGRS=$mgrs',
                controller: locationMGRS,
                isNote: false,
                readOnly: true,
                textInputType: TextInputType.text,
              ),
              FilledButton(
                  onPressed: () {
                    getLocation();
                  },
                  child: const Text('جلب الموقع')),
              //////////////////////
              //////////////////////////
              //////////////////
              ///////////////////////
              ////////////////////////////
              /////////////////////////////////////////////////
              //////////////////////////
              //////////////////
              ///////////////////////
              ////////////////////////////
              /////////////////////////////////////////////////
              //////////////////////////
              //////////////////
              ///////////////////////
              ////////////////////////////
              ///////////////////////////
              Pledge != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      child: Image.file(Pledge!),
                    )
                  : const Text('لم يتم التقاط صورة بعد'),
              ElevatedButton(
                onPressed: _pickImagePledge,
                child: const Text(' صورةالتعهد'),
              ),
              Form != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      child: Image.file(Form!),
                    )
                  : const Text('لم يتم التقاط صورة بعد'),
              ElevatedButton(
                onPressed: _pickImageForm,
                child: const Text('صورة الاستمارة'),
              ),
              IdentityInterface != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      child: Image.file(IdentityInterface!),
                    )
                  : const Text('لم يتم التقاط صورة بعد'),
              ElevatedButton(
                onPressed: _pickImageIdentityInterFace,
                child: const Text('صورة الهويه الامامية'),
              ),
              IdentityBackground != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      child: Image.file(IdentityBackground!),
                    )
                  : const Text('لم يتم التقاط صورة بعد'),
              ElevatedButton(
                onPressed: _pickImageIdentityBackground,
                child: const Text('صورة الهوية الخلفية'),
              ),
              CardInterface != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      child: Image.file(CardInterface!),
                    )
                  : const Text('لم يتم التقاط صورة بعد'),
              ElevatedButton(
                onPressed: _pickImageCardInterface,
                child: const Text('صورة البطاقة الامامية'),
              ),
              CardBackground != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      child: Image.file(CardBackground!),
                    )
                  : const Text('لم يتم التقاط صورة بعد'),
              ElevatedButton(
                onPressed: _pickImageCardBackground,
                child: const Text('صورة البطاقة الخلفية'),
              ),
              Other != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      child: Image.file(Other!),
                    )
                  : const Text('لم يتم التقاط صورة بعد'),
              ElevatedButton(
                onPressed: _pickImageOther,
                child: const Text('صورة اخرى'),
              ),
              //////////////////////
              //////////////////////////
              //////////////////
              ///////////////////////
              ////////////////////////////
              /////////////////////////////////////////////////
              //////////////////////////
              //////////////////
              ///////////////////////
              ////////////////////////////
              /////////////////////////////////////////////////
              //////////////////////////
              //////////////////
              ///////////////////////
              ////////////////////////////
              /////////////////////////////////////////////////
              //////////////////////////
              //////////////////
              ///////////////////////
              ////////////////////////////
              ///////////////////////////
              const SizedBox(height: 20),
              TextFieldWidget(
                hint: 'تاريخ الجرد   $date',
                controller: inventorydate,
                isNote: false,
                readOnly: true,
                textInputType: TextInputType.text,
              ),
              TextFieldWidget(
                hint: 'الملاحظات',
                controller: note,
                isNote: true,
                readOnly: false,
                textInputType: TextInputType.text,
              ),
              FilledButton(
                onPressed: () async {
                  if (note.text.isEmpty) {
                    note.text = 'لا يوجد';
                  }
                  int year = 2024, month = 7, day = 1;

                  if (tradeName.text.isEmpty ||
                      locationType.text.isEmpty ||
                      cameraType.text.isEmpty ||
                      numberOfCamera.text.isEmpty ||
                      mobileNumber.text.isEmpty ||
                      nameOFTheInventoryHolder.text.isEmpty ||
                      x == null ||
                      y == null ||
                      mgrs == null) {
                    print("object");
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Icon(Icons.error),
                        content: Text('يرجى مراجعه الحقوول هنالك حقل فارغ'),
                      ),
                    );
                  } else if (year >= selectedDate.year ||
                      month >= selectedDate.month ||
                      day > selectedDate.day) {
                    await adddatafile(imageName: tradeName.text, data: [
                      // الاسم التجاري
                      TextCellValue(tradeName.text),

                      //نوع الموقع
                      TextCellValue(locationType.text),
                      //اسم صاحب الموقع
                      TextCellValue(nameOfTheSiteOwner.text),
                      //نوع الكامرات
                      TextCellValue(cameraType.text),

                      //العدد
                      TextCellValue(numberOfCamera.text),

                      //رقم الموبايل
                      TextCellValue(mobileNumber.text),

                      //اسم القائم بالجرد
                      TextCellValue(nameOFTheInventoryHolder.text),

                      //جهة الجرد
                      TextCellValue(DropDownButtonWidget.retvalue),

                      //الاحداثي x,y
                      TextCellValue('x=$x,y=$y'),

                      //الاحداثي mgrs
                      TextCellValue(mgrs!),

                      //تاريخ الجرد
                      TextCellValue(date),

                      //الملاحظات
                      TextCellValue(note.text),
                    ]);
                    setState(() {
                      tradeName.clear();
                      locationType.clear();
                      cameraType.clear();

                      mobileNumber.clear();
                      nameOfTheSiteOwner.clear();
                      numberOfCamera.clear();
                      note.clear();
                      inventorySide.clear();
                    });

                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        icon: Icon(Icons.done),
                        title: Text('تمت اضافه البيانات بنجاح'),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Icon(Icons.error),
                        content: Text('يرجى مراجعه القسم للتحديث'),
                      ),
                    );
                  }
                },
                child: const Text('حفظ البيانات'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> adddatafile(
      {required List<CellValue> data, required String imageName}) async {
    Excel? excel;

    // var directory = await getApplicationCacheDirectory();

    String path = '/storage/emulated/0/Download';
    String filePath = '$path/dat.xlsx';
    File file = File(filePath);
    if (await file.exists()) {
      // file.delete();
      List<int> bytes = await file.readAsBytes();
      excel = Excel.decodeBytes(bytes);
      print(excel.tables);
    } else {
      excel = Excel.createExcel();
    }

    Sheet sheetObject = excel['Sheet1'];

    sheetObject.isRTL = true;
    if (sheetObject.maxRows == 0) {
      List<CellValue> heders = [
        const TextCellValue('الاسم التجاري'),
        const TextCellValue('نوع الموقع'),
        const TextCellValue('اسم صاحب الموقع'),
        const TextCellValue('نوع الكامرات'),
        const TextCellValue('عدد الكامرات'),
        const TextCellValue('رقم الموبايل'),
        const TextCellValue('اسم القائم بالجرد'),
        const TextCellValue('جهة الجرد'),
        const TextCellValue('الاحداثي x,y'),
        const TextCellValue('الاحداثي mgrs'),
        const TextCellValue('تاريخ الجرد'),
        const TextCellValue('الملاحظات'),
      ];
      sheetObject.appendRow(heders);
    }

    sheetObject.appendRow(data);

    print(sheetObject.maxRows);

    var fileBytes = excel.save();
    _saveImageToDirectory(Pledge!, '$imageName __${sheetObject.maxRows} تعهد');
    _saveImageToDirectory(Form!, '$imageName __${sheetObject.maxRows} استمارة');
    _saveImageToDirectory(
        IdentityInterface!, '$imageName __${sheetObject.maxRows} هويه اماميه');
    _saveImageToDirectory(
        IdentityBackground!, '$imageName __${sheetObject.maxRows} هويه خلفيه');
    _saveImageToDirectory(
        CardInterface!, '$imageName __${sheetObject.maxRows} بطاقة اماميه');
    _saveImageToDirectory(
        CardBackground!, '$imageName __${sheetObject.maxRows} بطاقه خلفيه');
    _saveImageToDirectory(Other!, '$imageName اخرى');
    File(join('$path/dat.xlsx'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    setState(() {
      Pledge = null;
      Form = null;
      IdentityBackground = null;
      IdentityInterface = null;
      CardInterface = null;
      CardBackground = null;
      Other = null;
    });
  }

  void convertMGRS({required double x, required double y}) {
    var point = [
      x,
      y,
    ];
    var accuracy = 5;

    mgrs = Mgrs.forward(point, accuracy);
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();
    if (locationData != null) {
      setState(() {
        setXandY(locationData.latitude!, locationData.longitude!);
      });
    }
  }

  setXandY(double lat, double long) {
    x = long;
    y = lat;
    convertMGRS(x: x!, y: y!);
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageForm() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        Form = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageIdentityInterFace() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        IdentityInterface = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageIdentityBackground() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        IdentityBackground = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageCardInterface() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        CardInterface = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageCardBackground() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        CardBackground = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImagePledge() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        Pledge = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageOther() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        Other = File(pickedFile.path);
      });
    }
  }

  Future<File?> _saveImageToDirectory(
      File imageFile, String nameOFImage) async {
    try {
      // مسار المجلد المطلوب
      const String dirPath = '/storage/emulated/0/Download/images';
      final Directory directory = Directory(dirPath);

      // تحقق من وجود المجلد، إذا لم يكن موجودًا قم بإنشائه
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // مسار الصورة داخل المجلد
      final String imagePath = path.join(dirPath, '$nameOFImage.jpg');
      final File savedImage = await imageFile.copy(imagePath);
      return savedImage;
    } catch (e) {
      print('Error saving image: $e');
      return null;
    }
  }
}
