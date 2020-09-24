import 'package:auto_route/auto_route_annotations.dart';
import 'package:firecek_stacked_architecture/ui/views/authenticate/authenticate_view.dart';
import 'package:firecek_stacked_architecture/ui/views/home/home_view.dart';
import 'package:firecek_stacked_architecture/ui/views/wrapper_view.dart';

@MaterialAutoRouter()
class $Router {
  // use @initial 
  @initial
  WrapperView wrapperViewRoute; // your desired route name

  AuthenticateView authenticateViewRoute;

  HomeView homeViewRoute;
}
