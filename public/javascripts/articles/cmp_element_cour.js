// Menu
 $(document).ready(function() {
     $('.cmp_bar_menu_element_cour').scrollToFixed();
 });

//$(function() {
//                $(window).scroll(function(){
//					var scrollTop = $(window).scrollTop();
//					if(scrollTop != 0)
//						$('.cmp_bar_menu_element_cour').stop().animate({'opacity':'0.1'},400);
//					else
//						$('.cmp_bar_menu_element_cour').stop().animate({'opacity':'1'},400);
//				});
//
//				$('.cmp_bar_menu_element_cour').hover(
//					function (e) {
//						var scrollTop = $(window).scrollTop();
//						if(scrollTop != 0){
//							$('.cmp_bar_menu_element_cour').stop().animate({'opacity':'1'},400);
//						}
//					},
//					function (e) {
//						var scrollTop = $(window).scrollTop();
//						if(scrollTop != 0){
//							$('.cmp_bar_menu_element_cour').stop().animate({'opacity':'0.1'},400);
//						}
//					}
//				);
//            });