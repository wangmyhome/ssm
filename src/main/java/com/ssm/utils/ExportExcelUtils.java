package com.ssm.utils;

import com.ssm.bean.User;
import com.ssm.vo.UserVo;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.formula.functions.T;
import org.apache.poi.ss.util.CellRangeAddress;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * @author shanpeng
 * @ClassName ExportExcelUtils
 * @description 导出Excel
 * @date 2020/1/6 14:46
 * @Version 1.0
 */
public class ExportExcelUtils {

    /**
     * 导出excel
     * @param lists
     * @param sheetName
     * @return
     */
    public static ByteArrayOutputStream exportCustomer(List<User> lists, String sheetName) {

        //1.组装excel文档
        //1.1创建工作簿
        HSSFWorkbook workbook = new HSSFWorkbook();
        //1.2创建样式
        HSSFCellStyle baseStyle = ExportHSSFCellStyle.createBaseStyle(workbook);
        HSSFCellStyle subTitleStyle = ExportHSSFCellStyle.createSubTitleStyle(workbook);
        HSSFCellStyle tableTitleStyle = ExportHSSFCellStyle.createTableTitleStyle(workbook);
        HSSFCellStyle titleStyle = ExportHSSFCellStyle.createTitleStyle(workbook);
        //1.3在工作簿创建sheet
        HSSFSheet sheet = workbook.createSheet(sheetName);
        //1.4设置sheet
        sheet.setDefaultColumnWidth(25);
        //1.5合并
        CellRangeAddress region1 = new CellRangeAddress(0, 0, 0, 7);
        CellRangeAddress region2 = new CellRangeAddress(1, 1, 0, 7);
        sheet.addMergedRegion(region1);
        sheet.addMergedRegion(region2);
        //1.6.1创建第一行
        int index=0;
        HSSFRow row1 = sheet.createRow(index);
        //1.6.2在第一行里面创建一个单元格
        HSSFCell row1_cell1 = row1.createCell(0);
        //1.6.3设置标题样式
        row1_cell1.setCellStyle(titleStyle);
        //1.6.4设置单元格内容
        row1_cell1.setCellValue("用户数据列表");

        //1.7.1第二行
        index++;
        HSSFRow row2 = sheet.createRow(index);
        //1.7.2在第一行里面创建一个单元格
        HSSFCell row2_cell1 = row2.createCell(0);
        //1.7.3设置标题样式
        row2_cell1.setCellStyle(subTitleStyle);
        //1.7.4设置单元格内容
        row2_cell1.setCellValue("总条数："+lists.size()+"   导出时间："+new Date().toLocaleString());

        //1.8.1第三行
        String[] titles={"用户编号","用户账号","密码","真实姓名","性别","用户邮箱","用户手机号","录入时间"};
        index++;
        HSSFRow row3 = sheet.createRow(index);
        for (int i = 0; i < titles.length; i++) {
            HSSFCell row3_cell = row3.createCell(i);
            row3_cell.setCellStyle(tableTitleStyle);
            row3_cell.setCellValue(titles[i]);
        }

        //1.9第四行
        for (int i = 0; i < lists.size(); i++) {
            index++;
            User user = lists.get(i);
            HSSFRow row = sheet.createRow(index);
            //1.9.1创建列用户编号
            HSSFCell row_id = row.createCell(0);
            row_id.setCellStyle(baseStyle);
            row_id.setCellValue(user.getId());
            //1.9.1创建列用户账号
            HSSFCell row_account = row.createCell(1);
            row_account.setCellStyle(baseStyle);
            row_account.setCellValue(user.getAccount());
            //1.9.1创建列密码
            HSSFCell row_password = row.createCell(2);
            row_password.setCellStyle(baseStyle);
            row_password.setCellValue(user.getPassword());
            //1.9.1创建列真实姓名
            HSSFCell row_real_name = row.createCell(3);
            row_real_name.setCellStyle(baseStyle);
            row_real_name.setCellValue(user.getRealName());
            //1.9.1创建列用户性别
            HSSFCell row_sex = row.createCell(5);
            row_sex.setCellStyle(baseStyle);
            row_sex.setCellValue(user.getSex()==1?"男":"女");
            //1.9.1创建列邮箱
            HSSFCell row_email = row.createCell(4);
            row_email.setCellStyle(baseStyle);
            row_email.setCellValue(user.getEmail());
            //1.9.1创建列手机号
            HSSFCell row_phone_number = row.createCell(4);
            row_phone_number.setCellStyle(baseStyle);
            row_phone_number.setCellValue(user.getPhoneNumber());
            //1.9.1创建列客户录入时间
            HSSFCell row_createtime = row.createCell(6);
            row_createtime.setCellStyle(baseStyle);
            row_createtime.setCellValue(user.getCreateTime().toLocaleString());
        }
        //到此excel组装完毕

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        //把workbook里面的数据写到outputStream

        try {
            workbook.write(outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return outputStream;

    }
}
