package com.pf.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

@Component //이클래스도 스프링관련파일이읽어질때 같이읽어져서 bean으로 등록됨 value값 생략(excelUtil) 로 값 지정됨 자동으로
public class ExcelUtil {
	
	private final Log logger = LogFactory.getLog(ExcelUtil.class);
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param datas		
	 * @param filename
	 * @param templateFile
	 */
	
	
	public String  exportExcel(HttpServletRequest request, 
				HttpServletResponse response, 
				Map<String , Object> datas, 
				String filename, 
				String templateFile) { //텔플릿파일이름
		
		
		// 현재 서비스가 돌아가고 있는 서버의 웹서비스 디렉토리의 물리적 경로
		String tempPath = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/templates") ; 
		// resources 안에있는 모든파일들은 배포할때 기준으로 web/inf 아래 classes폴더 안에 위치해 있다
		//실제템플릿파일의물리적인위치를작성
        
        try {
        	response.setContentType("application/vnd.ms-excel"); //파일다운로드할때도 resonse사용했다. 엑셀도 마찬가지로 엑셀다운로드지만 파일다운로드 그래서 resonse 쿼리문작성
        	response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + ".xlsx\"");
            
        	
        	InputStream is = new BufferedInputStream(
        	// inputstrean(읽어들이는통로) bufferinputstream
        	new FileInputStream(tempPath + "/" + templateFile + ".xlsx"));
        	
            XLSTransformer transformer = new XLSTransformer();
            // 엑셀데이터작성
            
            Workbook resultWorkbook = transformer.transformXLS(is, datas);
            //transformXLS(is, datas) 여기서 transformer메소드가 실행되면(엑셍의부서번호부서명읽어오면)   데이터전체를 읽어오는 xls실행
            //transformXLS 실행되면 workbook이라는 클래스가 생성된다.
            //인풋스틀림과 데이터를 
            
            OutputStream os = response.getOutputStream();
            //outpuststream 으로 보내줘야한다. resopnse(돌려줘야하는데) 에 나가는 통로를 열었다(getoutputstream)
            
            resultWorkbook.write(os);
            //내보낸다(write)
            
            os.flush();
            //flush() : 완벽히 종료
            
        } catch (ParsePropertyException | InvalidFormatException | IOException ex) {
            logger.error("ExcelUtil", ex);
            ex.printStackTrace();
        }
        return null;
	}
}
