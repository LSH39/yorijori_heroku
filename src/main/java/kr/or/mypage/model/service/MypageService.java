package kr.or.mypage.model.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.cookingCls.model.vo.CookingCls;
import kr.or.cookingCls.model.vo.CookingClsPageData;
import kr.or.cookingRsrv.model.vo.MyCookingRsrv;
import kr.or.coupon.model.vo.MyCoupon;
import kr.or.coupon.model.vo.MyCouponPageData;
import kr.or.freeboard.model.vo.Freeboard;
import kr.or.member.model.vo.Member;
import kr.or.member.model.vo.ReadMember;
import kr.or.mypage.model.dao.MypageDao;
import kr.or.mypage.model.vo.ContestWin;
import kr.or.mypage.model.vo.DetailOrder;
import kr.or.mypage.model.vo.FollowList;
import kr.or.mypage.model.vo.LikeRecipe;
import kr.or.mypage.model.vo.MyContest;
import kr.or.mypage.model.vo.MyFreeBoardPageData;
import kr.or.mypage.model.vo.MyItem;
import kr.or.mypage.model.vo.MyLikeRecipePageData;
import kr.or.mypage.model.vo.MyPointPageData;
import kr.or.mypage.model.vo.MySellPageData;
import kr.or.mypage.model.vo.Mychat;
import kr.or.mypage.model.vo.MycontestPagedata;
import kr.or.mypage.model.vo.Mydm;
import kr.or.mypage.model.vo.Mymembership;
import kr.or.mypage.model.vo.MymembershipPageData;
import kr.or.mypage.model.vo.Myorder;
import kr.or.mypage.model.vo.MyorderPageData;
import kr.or.mypage.model.vo.Mypoint;
import kr.or.mypage.model.vo.Mysell;
import kr.or.mypage.model.vo.ReadDm;
import kr.or.mypage.model.vo.followCount;
import kr.or.recipe.model.vo.RecipeBoard;
import kr.or.review.model.vo.MyClassReview;
import kr.or.review.model.vo.MyItemReview;
@Service
public class MypageService {
	@Autowired
	private MypageDao dao;

	public ReadMember mypage(String memberNickname) {
		//Member m =dao.mypage(memberId);
		//return m;

		ReadMember rm =dao.mypage(memberNickname);
		int dmCount =dao.countsDmFirst(memberNickname);
		rm.setDmCount(dmCount);
		return rm;
	}

	public int upMember(Member m) {
		int result = dao.updateMember(m);
		return result;
	}
/*
	public int deleteMember(Member m) {
		int result =dao.deleteMember(m);
		return result;
	}
*/
	/*
	public MyCoupon mycoupon(int memberNo) {
		MyCoupon mc =dao.myCoupon(memberNo);
		return mc;
	}
	 */
	/*
	public RecipeBoard myRecipe(int recipeWriter) {
		RecipeBoard re= dao.myRecipe(recipeWriter);
		return re;
	}
	 */
	public Member sellerPage(String memberId) {
		Member m =dao.sellerPage(memberId);
		return m;
	}
	/*
	public MyCookingRsrv myclass(int memberNo) {
		MyCookingRsrv mcr =dao.myClass(memberNo);
		return mcr;
	}
	 */
	/*
	public MyClassReview myclassReview(int memberNo) {
		MyClassReview mcrv =dao.myClassReview(memberNo);
		return null;
	}
	 */
	public ArrayList<RecipeBoard> myRecipe(int recipeWriter) {
		
		ArrayList<RecipeBoard> list = dao.myRecipe(recipeWriter);
		return list;
	}
	/*
	public ArrayList<MyCoupon> mycoupon(int memberNo) {
		ArrayList<MyCoupon> list = dao.myCoupon(memberNo);
		return list;
	}
	 */
	public ArrayList<MyCookingRsrv> myclass(int memberNo) {
		ArrayList<MyCookingRsrv> list =dao.myClass(memberNo);
		return list;
	}

	public ArrayList<MyClassReview> myclassReview(String memberNickname) {
		ArrayList<MyClassReview> list =dao.myClassReview(memberNickname);
		return list;
	}

	public ArrayList<MyItemReview> myItemReview(String memberNickname) {
		ArrayList<MyItemReview> list =dao.myItemReview(memberNickname);
		return list;
	}


	public ArrayList<ContestWin> contestWin() {
		ArrayList<ContestWin> list =dao.contestWin();
		return list;
	}

	public ArrayList<MyContest> myContest(int recipeWriter) {
		ArrayList<MyContest> list = dao.myContest(recipeWriter);
		return list;
	}

	public ArrayList<MyItem> myItem(int milkitWriter) {
		ArrayList<MyItem> list = dao.myItem(milkitWriter);
		return list;
	}
/*
	public ArrayList<LikeRecipe> likeRecipe(int memberNo) {
		ArrayList<LikeRecipe> list = dao.likeRecipe(memberNo);
		return list;
	}
*/


	public ArrayList<Freeboard> myBoard(String freeWriter) {
		ArrayList<Freeboard> list = dao.myBoard(freeWriter);
		return list;
	}

	public ArrayList<Mychat> myChatList(int chatReceive) {
		ArrayList<Mychat> list = dao.myChatList(chatReceive);
		for(int i=0; i<list.size(); i++) {
			Date beforeDate = list.get(i).getChatDate();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
			String newDate = simpleDateFormat.format(beforeDate);
			list.get(i).setChatDateStr(newDate);
		}
		return list;
	}


	/*
	public ArrayList<Myorder> myOrderList(int memberNo) {
		ArrayList<Myorder> list = dao.myOrderList(memberNo);
		return list;
	}
	 */

	public DetailOrder myOrderDetail(int orderNo) {
		DetailOrder mo =dao.myOrderDetail(orderNo);
		return mo;
	}

	public ArrayList<Myorder> orderDetail(int orderNo, String sessionMemberNickname) {
		ArrayList<Myorder> list = dao.orderDetail(orderNo);
		
		for(Myorder myorder : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("productNo", myorder.getProductNo());
			map.put("sessionMemberNickname", sessionMemberNickname);

			int prNo = dao.selectRvProductNo(map);
			myorder.setReviewNo(prNo);
		}
		
		return list;
	}
/*
	public ArrayList<Mysell> mySellList(int memberNo) {
		ArrayList<Mysell> list = dao.mySellerList(memberNo);
		return list;
	}
*/
	public ArrayList<Mysell> totalSell(int milkitWriter) {
		ArrayList<Mysell> list = dao.totalSell(milkitWriter);
		return list;
	}

	public int updateSeller(Member m) {
		int result = dao.updateSeller(m);
		return result;
	}


	
	
	/*???????????? ?????????*/
	public MyorderPageData orderList(int reqPage,int memberNo) {
		//???????????? ????????? ??????
		int numPerPage = 5;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;

		//??? ?????????
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", memberNo);
		map.put("start", start);
		map.put("end", end);
		ArrayList<Myorder> list = dao.selectOrderList(map);

		//????????? ??????????????? ??????
		int totalCount = dao.selectTotalCount(memberNo);
		int totalPage = 0;

		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		} else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

		String pageNavi = "<ul class='pagination'>";

		if(pageNo != 1) {
			pageNavi += "<li class=\"page\">";
			pageNavi += "<a class=\"page-link\" href='/myOrderList.do?memberNo="+memberNo+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
		}
		for(int i=0;i<pageNaviSize;i++){
			if(pageNo == reqPage) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class='page-link' href='/myOrderList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
			} else {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/myOrderList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<li class='page'>";
			pageNavi += "<a class='page-link' href='/myOrderList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		MyorderPageData mpd = new MyorderPageData(list,pageNavi,start,totalCount);
		return mpd;
	}

	/*???????????? ?????????*/
	public MyCouponPageData mycouponList(int reqPage,int memberNo) {
		//???????????? ????????? ??????
		int numPerPage = 5;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;

		//??? ?????????
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", memberNo);
		map.put("start", start);
		map.put("end", end);
		ArrayList<MyCoupon> list = dao.selectCouponList(map);

		//????????? ??????????????? ??????
		int totalCount = dao.couponTotalCount(memberNo);
		int totalPage = 0;

		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		} else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

		String pageNavi = "<ul class='pagination'>";

		if(pageNo != 1) {
			pageNavi += "<li class=\"page\">";
			pageNavi += "<a class=\"page-link\" href='/mycouponList.do?memberNo="+memberNo+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
		}
		for(int i=0;i<pageNaviSize;i++){
			if(pageNo == reqPage) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class='page-link' href='/mycouponList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
			} else {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/mycouponList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<li class='page'>";
			pageNavi += "<a class='page-link' href='/mycouponList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		MyCouponPageData cpd = new MyCouponPageData(list,pageNavi,start,totalCount);
		return cpd;
	}
	
	/*??? ?????? ???????????? ?????????*/
	public MycontestPagedata mycontestList(int reqPage,int recipeWriter) {
		//???????????? ????????? ??????
		int numPerPage = 5;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;

		//??? ?????????
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recipeWriter", recipeWriter);
		map.put("start", start);
		map.put("end", end);
		ArrayList<MyContest> list = dao.selectContestList(map);

		//????????? ??????????????? ??????
		int totalCount = dao.contestCount(recipeWriter);
		int totalPage = 0;

		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		} else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

		String pageNavi = "<ul class='pagination'>";

		if(pageNo != 1) {
			pageNavi += "<li class=\"page\">";
			pageNavi += "<a class=\"page-link\" href='/myContestList.do?recipeWriter="+recipeWriter+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
		}
		for(int i=0;i<pageNaviSize;i++){
			if(pageNo == reqPage) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class='page-link' href='/myContestList.do?recipeWriter="+recipeWriter+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
			} else {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/myContestList.do?recipeWriter="+recipeWriter+"&reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<li class='page'>";
			pageNavi += "<a class='page-link' href='/myContestList.do?recipeWriter="+recipeWriter+"&reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		MycontestPagedata ctpd = new MycontestPagedata(list,pageNavi,start,totalCount);
		return ctpd;
	}
	
	
    /*??? ????????? ?????????*/
	public MyFreeBoardPageData myfreeBoardList(int reqPage,String freeWriter) {
		//???????????? ????????? ??????
		int numPerPage = 5;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;

		//??? ?????????
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("freeWriter", freeWriter);
		map.put("start", start);
		map.put("end", end);
		ArrayList<Freeboard> list = dao.myBoardList(map);

		//????????? ??????????????? ??????
		int totalCount = dao.freeBoardCount(freeWriter);
		int totalPage = 0;

		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		} else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

		String pageNavi = "<ul class='pagination'>";

		if(pageNo != 1) {
			pageNavi += "<li class=\"page\">";
			pageNavi += "<a class=\"page-link\" href='/myBoardList.do?freeWriter="+freeWriter+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
		}
		for(int i=0;i<pageNaviSize;i++){
			if(pageNo == reqPage) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class='page-link' href='/myBoardList.do?freeWriter="+freeWriter+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
			} else {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/myBoardList.do?freeWriter="+freeWriter+"&reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<li class='page'>";
			pageNavi += "<a class='page-link' href='/myBoardList.do?freeWriter="+freeWriter+"&reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		MyFreeBoardPageData fpd = new MyFreeBoardPageData(list,pageNavi,start,totalCount);
		return fpd;
	}
	
	
    /*??? ????????? ?????????*/
	public MyLikeRecipePageData likeRecipeList(int reqPage,int memberNo) {
		//????????? ?????? - ???????????? ????????? ??????
		int numPerPage = 6;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;

		//??? ???????????? ????????? ????????? ?????? ??????
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", memberNo);
		map.put("start", start);
		map.put("end", end);
		ArrayList<LikeRecipe> list = dao.likeRecipeList(map);

		//????????? ??????????????? ??????
		int totalCount = dao.recipeCount(memberNo);
		int totalPage = 0;

		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		} else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

		String pageNavi = "<ul class='pagination'>";

		if(pageNo != 1) {
			pageNavi += "<li class=\"page\">";
			pageNavi += "<a class=\"page-link\" href='/myLikeList.do?memberNo="+memberNo+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
		}
		for(int i=0;i<pageNaviSize;i++){
			if(pageNo == reqPage) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class='page-link' href='/myLikeList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
			} else {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/myLikeList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<li class='page'>";
			pageNavi += "<a class='page-link' href='/myLikeList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		MyLikeRecipePageData rpd = new MyLikeRecipePageData(list,pageNavi,start,totalCount);
		return rpd;
	}

	/*?????????*/
		public followCount followList(int memberNo) {
		ArrayList<FollowList> list = dao.followList(memberNo);
	     int totalCount = dao.followCount(memberNo);
	     followCount fct = new followCount(list,totalCount);
			return fct;
		}
    /*??? ?????????*/

		public ReadDm myDmList(String dmReceiver) {
			ArrayList<Mydm> list = dao.myDmList(dmReceiver);
		     int dmCount = dao.countsDm(dmReceiver);
		     ReadDm rd = new ReadDm(list,dmCount);
				return rd;
		}

     
		public ArrayList<Mypoint> myPoint(String memberNo) {
			ArrayList<Mypoint> list = dao.mypoint(memberNo);
			return list;
		}

		
		public MyPointPageData pointList(int reqPage,int memberNo) {
			//???????????? ????????? ??????
			int numPerPage = 10;
			int end = reqPage * numPerPage;
			int start = end - numPerPage + 1;

			//??? ?????????
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", memberNo);
			map.put("start", start);
			map.put("end", end);
			ArrayList<Mypoint> list = dao.selectPointList(map);

			//????????? ??????????????? ??????
			int totalCount = dao.pointCount(memberNo);
			int totalPoint = dao.totalPoint(memberNo);
			int usePoint = dao.usePoint(memberNo);
			int totalPage = 0;

			if(totalCount%numPerPage == 0) {
				totalPage = totalCount/numPerPage;
			} else {
				totalPage = totalCount/numPerPage+1;
			}
			int pageNaviSize = 5;
			int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

			String pageNavi = "<ul class='pagination'>";

			if(pageNo != 1) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class=\"page-link\" href='/myPoint.do?memberNo="+memberNo+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
			}
			for(int i=0;i<pageNaviSize;i++){
				if(pageNo == reqPage) {
					pageNavi += "<li class=\"page\">";
					pageNavi += "<a class='page-link' href='/myPoint.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
				} else {
					pageNavi += "<li class='page'>";
					pageNavi += "<a class='page-link' href='/myPoint.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
					pageNavi += pageNo+"</a></li>";
				}
				pageNo++;
				if(pageNo>totalPage) {
					break;
				}
			}
			if(pageNo <= totalPage) {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/myPoint.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
				pageNavi += "&gt;</a></li>";
			}
			pageNavi += "</ul>";
			MyPointPageData ppd = new MyPointPageData(list,pageNavi,start,totalCount,totalPoint,usePoint);
			return ppd;
		}
		
   //??? ???????????????
		
		public CookingClsPageData selectMyClass(int reqPage, String memberNickname) {
			int numPerPage =5;
			
			int end = reqPage * numPerPage;
			int start = end - numPerPage + 1;
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberNickname",memberNickname);
			map.put("start", start);
			map.put("end", end);
			
			ArrayList<CookingCls> list = dao.selectMyClass(map);
			
			int totalCount = dao.totalClass(memberNickname);
			
			int totalPage = 0;
			if(totalCount%numPerPage==0) {
				totalPage = totalCount/numPerPage;
			}else {
				totalPage = (totalCount/numPerPage)+1;			
			}
			
			int pageNaviSize = 5; 
//			int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize +1;
			int pageNo = 0;
			if(reqPage>0 && reqPage<totalPage-4) {
				pageNo = reqPage;
			}else {
				pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize +1;
			}
			
			//????????? ?????? ??????
			String pageNavi = "<ul class='pagination pagination-lg'>";
			
			//?????? ?????? ??????
			if(pageNo != 1) {
				pageNavi += "<li class='page-item'>";
				pageNavi += "<a class='page-link' href='/mycookingList.do?memberNickname="+memberNickname+"&reqPage="+(pageNo-1)+"'>";
	
				pageNavi += "&lt;</a></li>";
			}
			
			//????????? ?????? ??????
			for (int i = 0; i < pageNaviSize; i++) {
				if(pageNo == reqPage) {
					pageNavi += "<li class='page-item active'>";
					pageNavi += "<a class='page-link' href='/mycookingList.do?memberNickname="+memberNickname+"&reqPage="+pageNo+"'>";
					pageNavi += pageNo+"</a></li>";
				}else {
					pageNavi += "<li class='page-item'>";
					pageNavi += "<a class='page-link' href='/mycookingList.do?memberNickname="+memberNickname+"&reqPage="+pageNo+"'>";
					pageNavi += pageNo+"</a></li>";
				}
				pageNo++;
				if(pageNo > totalPage) {
					break;
				}
			}
			
			//?????? ?????? ??????
			if(pageNo < totalPage) {
				pageNavi += "<li class='page-item'><a class='page-link' href='/mycookingList.do?memberNickname="+memberNickname+"&reqPage="+(reqPage+1)+"'>&gt;</a></li>";
			}
			
			pageNavi +="<ul>";
			
			CookingClsPageData ccpd = new CookingClsPageData(list, pageNavi, start);
			return ccpd;
		}
		
		
     /*????????? ??????,?????????*/
		public int updateCer(Member m) {
			int result = dao.upCerPath(m);
			return result;
		}
    /*????????? ????????????(????????? ????????? ??????)*/
		public int updateSell(Member m) {
			int result = dao.upSellerInfo(m);
			return result;
		}

		public Member profile(String memberId) {
			Member m =dao.profile(memberId);
			return m;
		}

		/*???????????? ??????*/
		public int uporder(Mysell ms) {
			 int result =dao.updateOrder(ms);
			return result;
		}
		/*????????? ????????????*/
		public int raisePoint(Mysell ms) {
			int result =dao.raisePoint(ms);
			return result;
		}
		/*????????? ????????????*/
		public int updatePoint(Mysell ms) {
			int result =dao.updatePoint(ms);
			return result;
		}

      //?????????????????????????????????
		public MySellPageData mySellList1(int reqPage,int milkitWriter) {
			//????????? ?????? - ???????????? ????????? ??????
			int numPerPage = 5;
			int end = reqPage * numPerPage;
			int start = end - numPerPage + 1;

			//??? ???????????? ????????? ????????? ?????? ??????
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("milkitWriter", milkitWriter);
			map.put("start", start);
			map.put("end", end);
			ArrayList<Mysell> list = dao.mySellerList1(map);

			//????????? ??????????????? ??????
			int totalCount = dao.sellCount(milkitWriter);
			int totalPage = 0;

			if(totalCount%numPerPage == 0) {
				totalPage = totalCount/numPerPage;
			} else {
				totalPage = totalCount/numPerPage+1;
			}
			int pageNaviSize = 5;
			int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

			String pageNavi = "<ul class='pagination'>";

			if(pageNo != 1) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class=\"page-link\" href='/sellList.do?milkitWriter="+milkitWriter+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
			}
			for(int i=0;i<pageNaviSize;i++){
				if(pageNo == reqPage) {
					pageNavi += "<li class=\"page\">";
					pageNavi += "<a class='page-link' href='/sellList.do?milkitWriter="+milkitWriter+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
				} else {
					pageNavi += "<li class='page'>";
					pageNavi += "<a class='page-link' href='/sellList.do?milkitWriter="+milkitWriter+"&reqPage="+pageNo+"'>";
					pageNavi += pageNo+"</a></li>";
				}
				pageNo++;
				if(pageNo>totalPage) {
					break;
				}
			}
			if(pageNo <= totalPage) {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/sellList.do?milkitWriter="+milkitWriter+"&reqPage="+pageNo+"'>";
				pageNavi += "&gt;</a></li>";
			}
			pageNavi += "</ul>";
			MySellPageData spd = new MySellPageData(list,pageNavi,start,totalCount);
			return spd;
		}
		
        //????????? ????????????(?????????)
		public ReadMember seller(String memberNickname) {
			ReadMember rm =dao.mypage(memberNickname);
			int dmCount =dao.countsDmFirst(memberNickname);
			rm.setDmCount(dmCount);
			return rm;
		}
       //????????????
		public int cancelOrder(int orderNo) {
			int result =dao.cancelOrder(orderNo);
			if(result>0) {
				 result=dao.cancelOrderList(orderNo);
			}
			return result;
		}
        //????????? ???????????????
		public int returnPoint(int orderSale, int memberNo) {
			int result =dao.returnPoint(orderSale,memberNo);
			return result;
		}
         //????????? ?????????(???????????????)

	
		public int upPoint(int orderSale, int memberNo) {
			int result =dao.upPoint(orderSale,memberNo);
			return result;
		}
		
        //????????? ????????????
		public MymembershipPageData membershipList(int reqPage, int memberNo) {
			//???????????? ????????? ??????
			int numPerPage = 5;
			int end = reqPage * numPerPage;
			int start = end - numPerPage + 1;

			//??? ?????????
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", memberNo);
			map.put("start", start);
			map.put("end", end);
			ArrayList<Mymembership> list = dao.selectmembership(map);

			//????????? ??????????????? ??????
			int totalCount = dao.totalmembership(memberNo);
			int totalPage = 0;

			if(totalCount%numPerPage == 0) {
				totalPage = totalCount/numPerPage;
			} else {
				totalPage = totalCount/numPerPage+1;
			}
			int pageNaviSize = 5;
			int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;

			String pageNavi = "<ul class='pagination'>";

			if(pageNo != 1) {
				pageNavi += "<li class=\"page\">";
				pageNavi += "<a class=\"page-link\" href='/myMembership.do?memberNo="+memberNo+"&reqPage="+(pageNo-1)+"'>&lt;</a></li>";
			}
			for(int i=0;i<pageNaviSize;i++){
				if(pageNo == reqPage) {
					pageNavi += "<li class=\"page\">";
					pageNavi += "<a class='page-link' href='/myMembership.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>"+pageNo+"</a></li>";
				} else {
					pageNavi += "<li class='page'>";
					pageNavi += "<a class='page-link' href='/myMembership.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
					pageNavi += pageNo+"</a></li>";
				}
				pageNo++;
				if(pageNo>totalPage) {
					break;
				}
			}
			if(pageNo <= totalPage) {
				pageNavi += "<li class='page'>";
				pageNavi += "<a class='page-link' href='/myMembership.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>";
				pageNavi += "&gt;</a></li>";
			}
			pageNavi += "</ul>";
			MymembershipPageData mem = new MymembershipPageData(list,pageNavi,start,totalCount);
			return mem;
		}

	
		
		

}
