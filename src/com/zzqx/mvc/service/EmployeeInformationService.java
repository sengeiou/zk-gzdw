package com.zzqx.mvc.service;


import com.zzqx.mvc.entity.EmployeeInformation;

import java.util.List;

public interface EmployeeInformationService {

    /**
     * 修改员工工作状态
     *
     */
    int updateByWatchCode(EmployeeInformation employeeInformation);

    /**
     * 根据WatchCode查询人员
     */
    List<EmployeeInformation> selectByWatchCode(EmployeeInformation employeeInformation);

    /**
     * 获取未绑定人员列表  不同营业厅
     */
    List<EmployeeInformation> selectNoboding(EmployeeInformation employeeInformation);
}
