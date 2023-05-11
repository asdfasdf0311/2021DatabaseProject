package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class SubjectDAO {
	private String jdbcDriver = "jdbc:mysql://localhost:3306/testdb?useSSL=false";
	private String dbUser = "root";
	private String dbPass = "Hayeon@0311";
	
	public SubjectDAO() {
	}
	
	
	public ArrayList<SubjectDTO> subjectSelect() {
		ArrayList<SubjectDTO> dtos = new ArrayList<SubjectDTO>();
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = con.createStatement();
			rs = stmt.executeQuery("select * from subject");
			
			while (rs.next()) {
				String sub_code = rs.getString("sub_code");
				String sub_name = rs.getString("sub_name");
				String sub_ename = rs.getString("sub_ename");
				String create_year = rs.getString("create_year");
				
				SubjectDTO dto = new SubjectDTO(sub_code, sub_name, sub_ename, create_year);
				dtos.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(con != null) con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return dtos;
	}
	
//	// �뜲�씠�꽣 �븯�굹留� �씫�뼱�삤湲�
//	public SubjectDTO subjectSelectOne(String code) {
//		Connection con = null;
//		Statement stmt = null;
//		ResultSet rs = null;
//		SubjectDTO dto = new SubjectDTO();
//		
//		try {
//			con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
//			stmt = con.createStatement();
//			rs = stmt.executeQuery("select * from subject where sub_code = " + code);
//			
//			while (rs.next()) {
//				String sub_code = rs.getString("sub_code");
//				String sub_name = rs.getString("sub_name");
//				String sub_ename = rs.getString("sub_ename");
//				String create_year = rs.getString("create_year");
//				
//				dto = new SubjectDTO(sub_code, sub_name, sub_ename, create_year);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if(rs != null) rs.close();
//				if(stmt != null) stmt.close();
//				if(con != null) con.close();
//			} catch(Exception e) {
//				e.printStackTrace();
//			}
//		}
//		
//		return dto;
//	}
//	
	// �뜲�씠�꽣 �궫�엯
	public int insertSubject(SubjectDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "insert into subject values (?, ?, ?, ?)";
		int result = 0;
	
		try {
			con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, dto.getSub_code());
			pstmt.setString(2, dto.getSub_name());
			pstmt.setString(3, dto.getSub_ename());
			pstmt.setString(4, dto.getCreate_year());
			
			result = pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// �뜲�씠�꽣 �궘�젣
	public int deleteSubject(String sub_code) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "delete from subject where sub_code = ?";
		int result = 0;
		try {
			con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, sub_code);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(con != null) con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	public int updateSubject(SubjectDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "update subject set sub_name = ?, sub_ename = ?, create_year = ? where sub_code = ?";
		int result = 0;
		try {
			con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, dto.getSub_name());
			pstmt.setString(2, dto.getSub_ename());
			pstmt.setString(3, dto.getCreate_year());
			pstmt.setString(4, dto.getSub_code());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(con != null) con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
}
