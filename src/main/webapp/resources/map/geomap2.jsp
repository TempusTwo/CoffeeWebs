<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>
     <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAHIDkaYDda-AK3u2_UpBWpAPcft4yDbrk&sensor=FALSE">
    </script>
    <script type="text/javascript">
      function initialize() {
    	var latlng = new google.maps.LatLng(37.432124,127.129064);     // 성남 모란역
        var mapOptions = {
          center: latlng,
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
        var marker = new google.maps.Marker({position:latlng, map:map});
        
        var geocoder = new google.maps.Geocoder();
        
        google.maps.event.addListener(map, 'click', function(event){
        	var location = event.latLng; //이벤트객체로부터 지리좌표 추출
        	//역 지오코딩 요청/응답
        	geocoder.geocode( {'latLng':location}, function(results, status) {
       		   if (status == google.maps.GeocoderStatus.OK) {
       		        map.setCenter(results[0].geometry.location);
                        $('#div1').empty();
       		        $('#div1').append('주소='+ results[0].formatted_address);
       		     	$('#div1').append('<br>');
       		        $('#div1').append('좌표='+ results[0].geometry.location);
       		      if(!marker) { //클릭시마다 마커를 새로 생성하면 마커의 수가 증가한다
       		      	marker = new google.maps.Marker({
       		        	map: map, position: results[0].geometry.location
       		      	});
       		      }else{ // 마커가 이미 있는 경우에는 아래처럼 처리하면 마커의 수가 증가하지 않는다
       		    	  marker.setMap(null);
       		    	  marker = new google.maps.Marker({
           		    	  map: map, position: results[0].geometry.location
           		    });
       		      }
       		   } else {
       		      alert("Geocode was not successful for the following reason: " + status);
       		   }
       		});
        });
      }
    </script>
  </head>
  <body onload="initialize()">
    <div id="map_canvas" style="width:100%; height:100%"></div>
    <div id="div1"></div>
  </body>
</html>