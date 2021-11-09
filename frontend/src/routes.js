import DeployContainer from "views/DeployContainer/DeployContainer.js";
import LoginPage from "views/Pages/LoginPage.js";
import RunAppService from "views/RunAppService/RunAppService.js";

// @material-ui/icons
import DashboardIcon from "@material-ui/icons/Dashboard";
import PlaylistPlayIcon from "@material-ui/icons/PlaylistPlay";
import Image from "@material-ui/icons/Image";

var dashRoutes = [
  {
    path: "/deployContainer",
    name: "container 배포",
    icon: DashboardIcon,
    component: DeployContainer,
    layout: "/admin",
  },
  {
    path: "/runAppService",
    name: "앱 서비스 실행",
    icon: PlaylistPlayIcon,
    component: RunAppService,
    layout: "/admin",
  },
  {
    path: "/login-page",
    name: "Login Page",
    icon: Image,
    component: LoginPage,
    layout: "/auth",
  },
];
export default dashRoutes;
