<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Arrays"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

 *{font-family: 'GangwonEdu_OTFBoldA', sans-serif;}
 

@media (max-width: 576px)
{
  .card-col 
  {
    width: 250px;
  }
}

 @media (min-width: 1400px) { 
   .card {
    width: 300px; 

  }
 }
  @media (max-width: 1399px) { 
   .card {
    width: 260px; 

  }
 }
 
   @media (max-width: 1200px) { 
   .card {
    width: 215px; 

  }
 }
 
    @media (max-width: 970px) { 
   .card {
    width: 150px; 

  }
 }
 .card
 {margin: 0 auto;
    } 



 
</style>
<meta charset="UTF-8">
<title>Exhibition Info</title>
   
</head>
<body>
   <%@ include file="login_nav.jsp" %>

   <%@ include file="main_nav.jsp" %>
   
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#seoulList" role="tab" aria-controls="seoulList" aria-selected="true">서울</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#gyeonggiList" role="tab" aria-controls="gyeonggiList" aria-selected="false">경기</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="contact-tab" data-toggle="tab" href="#GyeongbukList" role="tab" aria-controls="GyeongbukList" aria-selected="false">경북</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="contact-tab" data-toggle="tab" href="#busanList" role="tab" aria-controls="busanList" aria-selected="false">부산</a>
  </li>
</ul>

<div class="tab-content" id="myTabContent" style="margin-top: 20px; text-align: center;">
  <div class="tab-pane fade show active" id="seoulList" role="tabpanel" aria-labelledby="home-tab">
  </div>
  <div class="tab-pane fade" id="gyeonggiList" role="tabpanel" aria-labelledby="profile-tab">
    <!-- 경기 탭 내용 -->
  </div>
  <div class="tab-pane fade" id="GyeongbukList" role="tabpanel" aria-labelledby="contact-tab">
    <!-- 경북 탭 내용 -->
  </div>
  <div class="tab-pane fade" id="busanList" role="tabpanel" aria-labelledby="contact-tab">
    <!-- 부산 탭 내용 -->
  </div>
</div>


 <script>
    $(document).ready(function() {
      $.ajax({
        url: "test2",
        type: "GET",
        xhrFields: {
          withCredentials: true
        },
        success: function(data) {
          console.log(data);
          var jsonArray = JSON.parse(data);
         
          for (var i = 0; i < jsonArray.length; i++) {
           var realmName = jsonArray[i].realmName;  
            var title = jsonArray[i].title;
            var place = jsonArray[i].place;
            var startDate = jsonArray[i].startDate;
            var endDate = jsonArray[i].endDate;
            var area = jsonArray[i].area;
            var thumbnailImage = jsonArray[i].thumbnail ? jsonArray[i].thumbnail : "https://via.placeholder.com/150x150"; // 썸네일 이미지가 없을 경우 기본 이미지 사용

//             var cardEl = $("<div>").addClass("col-md-4").addClass("mb-4").addClass("d-inline-block");
            var cardEl = $("<div>").addClass("col-md-3").addClass("mb-4").addClass("d-inline-block").addClass("ml-3");
//             var cardEl = $("<div>").addClass("col-md-3").addClass("mb-4").addClass("d-inline-block");.addClass("ml-3")
//             var cardEl = $("<div>").addClass("col-md-3 mb-4 d-inline-block mr-3");

//             cardEl.css("width", "auto");
//             var cardEl = $("<div>").addClass("col-md-4 mb-4 d-inline-block mr-3");

            cardEl.css("width", "auto");
            cardEl.css("margin-left", "12px");
            cardEl.css("margin-right", "12px");




           
    


            var card = $("<div>").addClass("card h-100");
            var img = $("<img>").addClass("card-img-top").attr("src", thumbnailImage).attr("alt", "Card image cap").attr("style", "height:300px;");
            var cardBody = $("<div>").addClass("card-body");
            var cardRealm = $("<p>").addClass("card-text").text(realmName);
            var cardTitle = $("<h3>").addClass("card-title").text(title);
            var cardPlace = $("<p>").addClass("card-text").text(place);
            var cardText = $("<p>").addClass("card-text").text(startDate + " ~ " + endDate);
            var cardArea = $("<p>").addClass("card-text cardArea").text(area);
           
            console.log(cardArea.text());
            
         // 지역별 분기 처리
            if (cardArea.text() === "서울") {
           $("#seoulList").append(cardEl);
         } else if (cardArea.text() === "경기") {
           $("#gyeonggiList").append(cardEl);
         } else if (cardArea.text() === "경북") {
           $("#GyeongbukList").append(cardEl);
         }  else if (cardArea.text() === "부산") {
           $("#busanList").append(cardEl);
         }  else {
           $("#otherList").append(cardEl);
         }

            
            cardBody.append(cardTitle);
            cardBody.append(cardText);
            cardBody.append(cardRealm);
            cardBody.append(cardPlace);
            cardBody.append(cardArea);
            card.append(img);
            card.append(cardBody);
            cardEl.append(card);
            
            
            // 버튼 1
           var btn1 = $("<button>").addClass("btn btn-primary mr-2").text("구매하기");
            btn1.attr("data-card-info", JSON.stringify(jsonArray[i]));
            btn1.click(function() {
                var cardInfo = JSON.parse($(this).attr("data-card-info"));
                var queryString = "?realmName=" + cardInfo.realmName + "&title=" + encodeURIComponent(cardInfo.title) + "&place=" + cardInfo.place + "&thumbnail=" + encodeURIComponent(cardInfo.thumbnail);
                var contextPath = "<%=request.getContextPath()%>";
                var url = contextPath + "/buy";
                window.location.href = url + queryString;
            });
            
            cardBody.append(btn1);


            // 버튼 2
            var btn2 = $("<button>").addClass("btn btn-secondary float-right ml-2").text("리뷰모음");
            btn2.attr("data-card-info", JSON.stringify(jsonArray[i]));
            btn2.click(function() {
                var cardInfo = JSON.parse($(this).attr("data-card-info"));
                var queryString = "?realmName=" + cardInfo.realmName + "&title=" + encodeURIComponent(cardInfo.title) + "&place=" + cardInfo.place + "&thumbnail=" + encodeURIComponent(cardInfo.thumbnail);
                var contextPath = "<%=request.getContextPath()%>";
                var url = contextPath + "/titleboard";
                window.location.href = url + queryString;      
            });
            
            cardBody.append(btn2);


          }
        },
    error: function(xhr, status, error) {
      console.error(xhr, status, error);
    }
  });
});
</script>



   <%@ include file="footer.jsp" %>
</body>
</html>