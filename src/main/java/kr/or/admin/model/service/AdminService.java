package kr.or.admin.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.admin.model.dao.AdminDao;
import kr.or.admin.model.vo.Member2;
import kr.or.admin.model.vo.MemberPageData;


@Service
public class AdminService {
	@Autowired
	AdminDao dao;
	

	public MemberPageData allMemberList(int reqPage, String searchType, String searchText, String searchDetail, String period, String start2, String end2, String moreless, String joinStart, String joinEnd,String detail,String align, String memberLevel,String searchText2,int level,String gotothe) {

	

		int numPerPage =30;
		if(align!=null) {
			numPerPage = Integer.parseInt(align);
		}
		int end = reqPage*numPerPage;
		int start = end - numPerPage+1;
		
		
		ArrayList<Member2> list = dao.allMemberList(searchType,searchText,searchDetail,period,start2,end2,moreless,joinStart,joinEnd,detail,memberLevel,searchText2,level);
		

		

		int totalCount = list.size();
		

		int totalPage=0;

		if(totalCount % numPerPage==0) {

			totalPage = totalCount/numPerPage;

		}else {

			totalPage=totalCount/numPerPage+1;

		}

		

		int pageNaviSize = 5;

		int pageNo=((reqPage-1)/pageNaviSize)*pageNaviSize+1;

		String pageNavi = "<ul class='pagination pagination-lg'>";

		if(pageNo != 1) {

			pageNavi += "<li class='page-item'>";

			pageNavi += "<a class='page-link' href='/"+gotothe+".do?reqPage=" + (pageNo - 1) + "&align="+numPerPage+"'>";

			pageNavi += "&lt;</a></li>";

		}

		for (int i = 0; i < pageNaviSize; i++) {

			if (pageNo == reqPage) {

				pageNavi += "<li class='page-item active'>";

				pageNavi += "<a class='page-link' href='"+gotothe+".do?reqPage=" + pageNo + "&align="+numPerPage+"'>";

				pageNavi += pageNo + "</a></li>";

			} else {

				pageNavi += "<li class='page-item'>"; 

				pageNavi += "<a class='page-link' href='"+gotothe+".do?reqPage=" + pageNo +"&align="+numPerPage+"'>";

				pageNavi += pageNo + "</a></li>";

			}

			pageNo++;

			if (pageNo > totalPage) {

				break;

			}

		}

		if (pageNo <= totalPage) {

			pageNavi += "<li class='page-item'>";

			pageNavi += "<a class='page-link' href='"+gotothe+".do?reqPage=" + pageNo + "&align="+numPerPage+"'>";

			pageNavi += "&gt;</a></li>";

		}

		pageNavi += "</ul>";

		

		MemberPageData mpd = new MemberPageData(list,pageNavi,start);

		

		return mpd;
		
		
	}

	public int addBlackMember(String memberNo) {
		int result = dao.addBlackMember(memberNo);
		return result;
	}

	public int addNormalMember(String memberNo) {
		int result = dao.addNormalMember(memberNo);
		return result;
	}

	public int deleteMember(String memberNo) {
		int result = dao.deleteMember(memberNo);
		return result;
	}

	public int addJori(String memberNo) {
		int result = dao.addJori(memberNo);
		return result;
	}
}
