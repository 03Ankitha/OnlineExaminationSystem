<%@page import="com.helper.*"%>
<%@page import="com.entity.*"%>
<%@page import="java.util.List"%>

<%
DatabaseClass DAO = new DatabaseClass();
String pageParam = request.getParameter("page");
%>

<%

/* ====================== ADD NEW USER ========================== */
if ("NewUser".equals(pageParam)) {

    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String phone_no = request.getParameter("phone_no");
    String password = request.getParameter("password");

    if (DAO.UserValidate(email)) {

        // skipping OTP complexity for now (to avoid bugs)
        User user = new User();
        user.setId(RandomIdGenerator.generateRandomString());
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone_no(phone_no);
        user.setCreated_Date(DateFormat.getCurrentDate());

        if (DAO.saveUser(user)) {
            response.sendRedirect("User-Login.jsp?msg=successfully");
        } else {
            response.sendRedirect("User-Login.jsp?msg=unsuccessfully");
        }

    } else {
        response.sendRedirect("User-Login.jsp?msg=Already");
    }
}


/* ====================== USER LOGIN ========================== */
else if ("LoginUser".equals(pageParam)) {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (DAO.UserLoginValidate(email, password)) {

        session.setAttribute("UserStatus", "1");
        session.setAttribute("UserId", DAO.getUserId(email, password));

        // ✅ FIXED (redirect)
        response.sendRedirect("User-Page.jsp?pg=1");

    } else {

        // ✅ FIXED (redirect)
        response.sendRedirect("User-Login.jsp?msg=unsuccessfully1");
    }
}


/* ====================== STUDENT LOGIN ========================== */
else if ("LoginStudent".equals(pageParam)) {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (DAO.studLoginValidate(email, password)) {

        session.setAttribute("studStatus", "1");
        session.setAttribute("studId", DAO.getstudId(email, password));

        // ✅ FIXED
        response.sendRedirect("stud-Page.jsp?spg=1");

    } else {

        // ✅ FIXED
        response.sendRedirect("Student-Login.jsp?msg=unsuccessfully1");
    }
}


/* ====================== LOGOUT USER ========================== */
else if ("logout1".equals(pageParam)) {

    session.setAttribute("UserStatus", "0");
    session.removeAttribute("UserId");

    response.sendRedirect("index.jsp");
}


/* ====================== LOGOUT STUDENT ========================== */
else if ("logout".equals(pageParam)) {

    session.setAttribute("studStatus", "0");
    session.removeAttribute("studId");

    response.sendRedirect("index.jsp");
}

/* ====================== CREATE BATCH ========================== */
else if ("createbatch".equals(pageParam)) {
    String batchname = request.getParameter("batchname");
    String addedby = request.getParameter("addedby");

    Batch batch = new Batch();
    batch.setBatchid(RandomIdGenerator.generateRandomString());
    batch.setBatchname(batchname);
    batch.setAddedby(addedby);
    batch.setAddeddate(DateFormat.getCurrentDate());

    DAO.addBatch(batch);
    response.sendRedirect("User-Page.jsp?pg=2");
}

/* ====================== EDIT BATCH ========================== */
else if ("editbatch".equals(pageParam)) {
    String batchid = request.getParameter("batchid");
    String batchname = request.getParameter("batchname");
    DAO.updatebatchDetails(batchid, batchname);
    response.sendRedirect("User-Page.jsp?pg=2");
}

/* ====================== ADD STUDENT ========================== */
else if ("addStudent".equals(pageParam)) {
    Student stud = new Student();
    stud.setStudentid(RandomIdGenerator.generateRandomString());
    stud.setFirstname(request.getParameter("fname"));
    stud.setMiddlename(request.getParameter("mname"));
    stud.setLastname(request.getParameter("lname"));
    stud.setStudentemailid(request.getParameter("emailid"));
    stud.setStudentaddress(request.getParameter("address"));
    stud.setStudentpassword(request.getParameter("password"));
    stud.setPhoneno(request.getParameter("phoneno"));
    stud.setRollno(request.getParameter("rollno"));
    stud.setStudentaddedby(request.getParameter("addedby"));
    stud.setStudentgender(request.getParameter("gender"));
    stud.setStudentdob(DateFormat.getsqlDate(request.getParameter("dob")));
    stud.setStudentbatch(request.getParameter("batch"));
    stud.setStudentaddedon(DateFormat.getCurrentDate());
    stud.setStudentstatus(request.getParameter("status"));

    DAO.saveStudent(stud);
    response.sendRedirect("User-Page.jsp?pg=2");
}


else if ("EditStudentDetail".equals(pageParam)) {
    String studentid = request.getParameter("studentid");
    String fname = request.getParameter("fname");
    String mname = request.getParameter("mname");
    String lname = request.getParameter("lname");
    String address = request.getParameter("address");
    String password = request.getParameter("password");
    String rollno = request.getParameter("rollno");
    String gender = request.getParameter("gender");
    String dob = request.getParameter("dob");
    String status = request.getParameter("status");
    DAO.updateStudentDetails(studentid, fname, mname, lname, address,
        password, rollno, gender,
        DateFormat.getsqlDate(dob), status);
    response.sendRedirect("User-Page.jsp?pg=2");
}
/* ====================== ADD EXAM ========================== */
else if ("createexam".equals(pageParam)) {
    Exam exam = new Exam();
    exam.setExamid(RandomIdGenerator.generateRandomString());
    exam.setExamtitle(request.getParameter("examtitle"));
    exam.setExamdesc(request.getParameter("examdesc"));
    exam.setExamduration(request.getParameter("examduration"));
    exam.setTotalQues("0");
    exam.setMarkright(request.getParameter("markright"));
    exam.setMarkwrong(request.getParameter("markwrong"));
    exam.setAddedby(request.getParameter("addedby"));

    DAO.addexam(exam);
    response.sendRedirect("User-Page.jsp?pg=3");
}

/* ====================== EDIT EXAM ========================== */
else if ("editexam".equals(pageParam)) {
    String examid = request.getParameter("examid");
    String examtitle = request.getParameter("examtitle");
    String examduration = request.getParameter("examduration");
    String markright = request.getParameter("markright");
    String markwrong = request.getParameter("markwrong");
    String examdesc = request.getParameter("examdesc");
    DAO.updateExamDetails(examid, examtitle, examduration, "0", markright, markwrong, examdesc);
    response.sendRedirect("User-Page.jsp?pg=3");
}



/* ====================== ADD QUESTION ========================== */
else if ("addquestion".equals(pageParam)) {
    Question ques = new Question();
    ques.setQuesid(RandomIdGenerator.generateRandomString());
    ques.setQues(request.getParameter("ques"));
    ques.setQdesc(request.getParameter("qdesc"));
    ques.setOptn1(request.getParameter("optn1"));
    ques.setOptn2(request.getParameter("optn2"));
    ques.setOptn3(request.getParameter("optn3"));
    ques.setOptn4(request.getParameter("optn4"));
    ques.setAns(request.getParameter("ans"));
    ques.setExamid(request.getParameter("qexamid"));
    ques.setAddedby(request.getParameter("addedby"));

    DAO.addques(ques);
    response.sendRedirect("User-Page.jsp?pg=3");
}

/* ====================== ADD NOTICE ========================== */
else if ("instrct".equals(pageParam)) {
    Notice no = new Notice();
    no.setNoticeid(RandomIdGenerator.generateRandomString());
    no.setNoticetitle(request.getParameter("topic"));
    no.setDescription(request.getParameter("description"));
    no.setAddedby(request.getParameter("addedby"));
    DAO.addnotice(no);
    response.sendRedirect("User-Page.jsp?pg=7");
}

/* ====================== ADD ENROLL ========================== */
else if ("enroll".equals(pageParam)) {
    Enroll enroll = new Enroll();
    enroll.setEnrollid(RandomIdGenerator.generateRandomString());
    enroll.setEnbatchid(request.getParameter("enbatchid"));
    enroll.setEnexamid(request.getParameter("enexamid"));
    enroll.setEnstatus("Active");
    enroll.setAddedby(request.getParameter("addedby"));

    DAO.adden(enroll);
    response.sendRedirect("User-Page.jsp?pg=5");
}


/* ====================== ADD RESULT ========================== */
else if ("addResult".equals(pageParam)) {
    Result res = new Result();
    res.setResultid(RandomIdGenerator.generateRandomString());
    res.setExamid(request.getParameter("examid"));
    res.setStudid(request.getParameter("studid"));
    res.setMarks(request.getParameter("marks"));
    res.setTotalmarks(request.getParameter("totalmarks"));
    res.setExstatus(request.getParameter("exstatus"));

    DAO.insertResult(res);
    response.sendRedirect("User-Page.jsp?pg=6");
}

/* ====================== SUBMIT EXAM ========================== */
else if ("exams".equals(pageParam)) {
    String sid = (String) session.getAttribute("studId");
    String size = request.getParameter("size");
    int totalsize = Integer.parseInt(size);
    String totalmarks = request.getParameter("totalmarks");
    String totalmarksw = request.getParameter("totalmarksw");
    String marktot = request.getParameter("marktot");
    
    int obtainedMarks = 0;
    
    for (int k = 0; k < totalsize; k++) {
        String questionid = request.getParameter("questionid" + k);
        String selectedAnswer = request.getParameter("answer");
        String examid = request.getParameter("cexamid" + k);
        
        Question q = DAO.getquesDetails(questionid);
        String correctAnswer = q.getAns();
        
        String mark = "0";
        if (selectedAnswer != null && selectedAnswer.equals(correctAnswer)) {
            mark = totalmarks;
            obtainedMarks += Integer.parseInt(totalmarks);
        } else if (selectedAnswer != null && !selectedAnswer.equals("NOTSELECTED")) {
            mark = totalmarksw;
            obtainedMarks += Integer.parseInt(totalmarksw);
        }
        
        Answer ans = new Answer();
        ans.setAnsid(RandomIdGenerator.generateRandomString());
        ans.setExId(examid);
        ans.setQuestionid(questionid);
        ans.setOpt(selectedAnswer != null ? selectedAnswer : "NOTSELECTED");
        ans.setMark(mark);
        ans.setSid(sid);
        DAO.insertAnswer(ans);
    }
    
    String examid = request.getParameter("cexamid0");
    Result res = new Result();
    res.setResultid(RandomIdGenerator.generateRandomString());
    res.setExamid(examid);
    res.setStudid(sid);
    res.setMarks(String.valueOf(obtainedMarks));
    res.setTotalmarks(marktot);
    res.setExstatus("Completed");
    DAO.insertResult(res);
    
    session.removeAttribute("examStatus");
    session.removeAttribute("startexam");
    
    response.sendRedirect("stud-Page.jsp?spg=1");
}

%>