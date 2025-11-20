package kr.or.standard.basic.module;


import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class ExcelUtil {
    
    
	/**
	 * 엑셀 읽기
	 * @param clazz : 반환 객체타입
	 * @param headerField : {"변수명", "변수명"}
	 * @param file : 엑셀 파일
	 * @param sheetNum : 엑셀시트 번호(First = 0)
	 * @return Success : List<T>, Fail : null
	 */
	public <T> List<T> readExcel(Class<T> clazz, String[] headerField, Integer sheetNum, FileInputStream file) {
		// List return 객체 생성
		List<T> resultList = new ArrayList<>();

		try {
			// 엑셀파일 읽는 Workbook 객체 생성
			Workbook workbook = WorkbookFactory.create(file);
			// 시트번호
			Sheet sheet = workbook.getSheetAt(sheetNum);
			// 행 반복자 생성
			Iterator<Row> rowIterator = sheet.iterator();

			// 첫 번째 행 스킵
			if (rowIterator.hasNext()) {
				rowIterator.next();
			}

			while (rowIterator.hasNext()) {
				// 객체 생성
				T obj = clazz.getDeclaredConstructor().newInstance();
				// 현재 행 가져오기
				Row row = rowIterator.next();
				// 각 행의 셀 반복자 생성
				Iterator<Cell> cellIterator = row.cellIterator();

				for (int i = 0; i < headerField.length; i++) {
					if (cellIterator.hasNext()) {
						Cell cell = cellIterator.next();
						// 해당 셀의 데이터
						String cellVal = cell.toString();
						try {
							// 해당 필드 찾기
							Field field = clazz.getDeclaredField(headerField[i]);
							// 필드 접근 가능하도록 설정
							field.setAccessible(true);
							// 필드 타입 가져오기
							Class<?> fieldType = field.getType();
							// 셀의 값을 필드 타입에 맞게 변환하여 설정
							if (fieldType == String.class) {
								field.set(obj, cellVal);
							} else if (fieldType == Integer.class || fieldType == int.class) {
								field.set(obj, Integer.parseInt(cellVal));
							} // 필요한 경우 다른 타입에 대한 처리 추가
						} catch (NoSuchFieldException e) {
							log.info("해당 객체에 변수가 존재하지 않습니다 :: 변수명 = {} , 객체 = {} ", headerField[i] , clazz.getSimpleName() );
							return null;
						}
					}
				}

				// 결과 리스트에 추가
				resultList.add(obj);
			}
		} catch (Exception e) {
			log.info("엑셀 파일을 읽는 중 에러가 발생했습니다.");
			resultList = null;
		}

		return resultList;
	}

}
