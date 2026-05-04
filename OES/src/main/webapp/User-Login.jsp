<%
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
   <meta charset="utf-8">
   <title>User Login</title>
   <link rel="stylesheet" href="css/User-Login-Register.css">
   <link rel="stylesheet" href="css/nav.css">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="shortcut icon" type="image/x-icon" href="img/logo2.png">
</head>

<body>

<nav class="main-nav flex-div">
   <div class="main-nav-left flex-div">
      <i class="fa fa-bars" aria-hidden="true" id="menu-icon"></i>
      <a href="index.jsp" class="nav-logo">Online Examination System</a>
   </div>
   <div class="main-nav-right flex-div">
      <a href="Student-Login.jsp?msg=1">
         <button class="stud-login-btn">Student Login</button>
      </a>
   </div>
</nav>

<div class="new">
   <div class="wrapper1">
      <img src="img/20824344_6343825.jpg" alt="User Login">
   </div>

   <div class="wrapper2">
      <div class="wrapper">

         <div class="title-text">
            <div class="title login">User Login</div>
            <div class="title signup">Sign up</div>
         </div>

         <div class="form-container">
            <div class="slide-controls">
               <input type="radio" name="slide" id="login" checked>
               <input type="radio" name="slide" id="signup">
               <label for="login" class="slide login">Login</label>
               <label for="signup" class="slide signup">Sign up</label>
               <div class="slider-tab"></div>
            </div>

            <div class="form-inner">

               <!-- LOGIN FORM -->
               <form action="Controller.jsp" method="post" class="login">
                  <input type="hidden" name="page" value="LoginUser">

                  <div class="field">
                     <input type="email" name="email" placeholder="Email" required>
                  </div>

                  <div class="field">
                     <input type="password" name="password" placeholder="Password" required>
                  </div>

                  <div class="field btn">
                     <input type="submit" value="Login">
                  </div>

                  <div class="signup-link">
                     Not a member? <a id="showSignup">Signup now</a>
                  </div>

                  <!-- MESSAGES -->
                  <%
                  if("successfully".equals(msg)) {
                  %>
                     <div class="signup-link-1">Successfully Registered</div>
                  <%
                  }
                  if("unsuccessfully".equals(msg)) {
                  %>
                     <div class="signup-link-1">Something went wrong. Try again</div>
                  <%
                  }
                  if("unsuccessfully1".equals(msg)) {
                  %>
                     <div class="signup-link-2">Email or Password wrong</div>
                  <%
                  }
                  if("OTPisincorrect".equals(msg)) {
                  %>
                     <div class="signup-link-2">OTP is incorrect</div>
                  <%
                  }
                  if("Already".equals(msg)) {
                  %>
                     <div class="signup-link-1">Already Registered</div>
                  <%
                  }
                  %>

               </form>

               <!-- SIGNUP FORM -->
               <form action="Controller.jsp" method="post" class="signup">
                  <input type="hidden" name="page" value="NewUser">

                  <div class="field">
                     <input type="text" name="username" placeholder="User Name" required>
                  </div>

                  <div class="field">
                     <input type="email" name="email" placeholder="Email" required>
                  </div>

                  <div class="field">
                     <input type="password" name="password" placeholder="Password" required>
                  </div>

                  <div class="field">
                     <input type="tel" name="phone_no" placeholder="Contact No" required pattern="[0-9]{10}">
                  </div>

                  <div class="field btn">
                     <input type="submit" value="Sign up">
                  </div>

               </form>

            </div>
         </div>
      </div>
   </div>
</div>

<script>
const loginForm = document.querySelector("form.login");
const loginText = document.querySelector(".title-text .login");
const loginBtn = document.querySelector("label.login");
const signupBtn = document.querySelector("label.signup");
const signupLink = document.getElementById("showSignup");

signupBtn.onclick = function () {
   loginForm.style.marginLeft = "-50%";
   loginText.style.marginLeft = "-50%";
};

loginBtn.onclick = function () {
   loginForm.style.marginLeft = "0%";
   loginText.style.marginLeft = "0%";
};

signupLink.onclick = function () {
   signupBtn.click();
};
</script>

</body>
</html>