
// 모든 dom 요소가 로딩 완료된 상태!!
$("#btn-login").on("click", function () {
    let id = prompt("아이디를 입력하세요", "");
    if (!id) {
      alert("아이디는 필수 입력입니다.");
      return;
    }
    let pass = prompt("비번을 입력하세요", "");
    if (!pass) {
      alert("비번을 필수 입력 사항");
      return;
    }
  
    if (id === "ssafy" && pass === "1234") {
      alert("로그인 성공");
    } else {
      alert("로그인 실패");
    }
    // 요소들의 상태 바꿔볼까??
    $(".before-login").css("display", "none");
    $(".after-login").css("display", "inline-block");
  });


// btn-signup 클릭 시 signup.html 띄우기
$("#btn-signup").on("click", function () {
    open("./signup.html", "login", 'top=10, left=10, width=700, height=900, status=no, menubar=no, toolbar=no, resizable=no')
})

// btn-create-accout(signup 창에서 create account 누르기)이 클릭되면
$("#btn-create-account").on("click", function () {
    // 현재 창 닫기
    self.close()
})

$("#btn-account-close").on("click", function(){
    self.close()
})


$("#btn-logout").on("click", function(){
    $(".before-login").css("display", "inline-block");
    $(".after-login").css("display", "none");
    open("./index.html", "index")
})

$("#btn-del").on("click", function(){
    let returnCheck = confirm("탈퇴 하시겠습니까?")
    if(returnCheck){
        alert("탈퇴되셨습니다.")
    }else{
        return
    }
})

// btn-findpass 클릭 시 findpass.html 띄우기
$("#btn-findpass").on("click", function () {
  open("./findpass.html", "login", 'top=10, left=10, width=700, height=900, status=no, menubar=no, toolbar=no, resizable=no')
})

$("#btn-find-password").on("click", function(){
  let name = $('#inputFindName').val();
  let id = $('#inputFindID').val();

  if (name == "kimssafy" && id == "ssafy" ) {
    alert("임시비밀번호 발급 : #1234");
  } else {
    alert("가입된 내역이 없습니다.");
  }

})