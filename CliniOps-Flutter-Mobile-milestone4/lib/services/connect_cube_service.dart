// import 'package:clini_app/data/data.dart';
// import 'package:clini_app/utils/utils.dart';
// // import 'package:connectycube_sdk/connectycube_sdk.dart';

// class ConnectCubeService {
//   static final ConnectCubeService _instance = ConnectCubeService._internal();

//   factory ConnectCubeService() => _instance;

//   ConnectCubeService._internal();

//   static CubeSession? _session;

//   Future<void> initialize() async {
//     try {
//       await init(CUBE_APP_ID, CUBE_AUTH_KEY, CUBE_AUTH_SECRET);
//       await ConnectCubeService().createCubeSession();
//     } catch (e) {
//       Logger.logError(this, e);
//     }
//   }

//   Future<CubeSession?> createCubeSession([CubeUser? cubeUser]) async {
//     _session = await createSession(cubeUser);
//     return _session;
//   }

//   Future<Responser<CubeUser>> signupUser(
//     String login,
//     String password,
//   ) async {
//     try {
//       final user = CubeUser(login: login, password: password);
//       return Responser(
//         message: 'Login success',
//         isSuccess: true,
//         data: await signUp(user),
//       );
//     } catch (e) {
//       return ErrorHandler.error<CubeUser>(e);
//     }
//   }

//   Future<Responser<CubeUser>> getUserFromLogin(String login) async {
//     try {
//       final user = await getUserByLogin(login);
//       return Responser(
//         message: 'Login success',
//         isSuccess: true,
//         data: user,
//       );
//     } catch (e) {
//       return ErrorHandler.error<CubeUser>(e);
//     }
//   }

//   Future<Responser<CubeDialog>> createChatDialog(int userId) async {
//     final newDialog =
//         CubeDialog(CubeDialogType.PRIVATE, occupantsIds: [userId]);
//     try {
//       final dialog = await createDialog(newDialog);
//       return Responser(
//         message: 'Chat dialog created',
//         isSuccess: true,
//         data: dialog,
//       );
//     } catch (e) {
//       return ErrorHandler.error<CubeDialog>(e);
//     }
//   }

//   Future<Responser<CubeUser>> loginUser(CubeUser user) async {
//     try {
//       CubeUser? cubeUser;

//       if (CubeChatConnection.instance.isAuthenticated()) {
//         cubeUser = CubeChatConnection.instance.currentUser;
//       } else {
//         cubeUser = await CubeChatConnection.instance.login(user);
//       }

//       return Responser<CubeUser>(
//         message: 'Login success',
//         isSuccess: true,
//         data: cubeUser,
//       );
//     } catch (e) {
//       Logger.logError(this, e);
//       return ErrorHandler.error<CubeUser>(e);
//     }
//   }

//   Future<Responser<PagedResult<CubeDialog>>> getChatDialogs() async {
//     try {
//       final dialogs = await getDialogs();
//       return Responser(
//         message: 'Chat dialog created',
//         isSuccess: true,
//         data: dialogs,
//       );
//     } catch (e) {
//       return ErrorHandler.error<PagedResult<CubeDialog>>(e);
//     }
//   }
// }
