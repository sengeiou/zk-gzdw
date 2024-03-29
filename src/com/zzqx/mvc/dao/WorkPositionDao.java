package com.zzqx.mvc.dao;

import org.springframework.stereotype.Component;

import com.jetsum.core.orm.hibernate.HibernateDao;
import com.zzqx.mvc.entity.WorkPosition;

@Component
public class WorkPositionDao extends HibernateDao<WorkPosition, String> {
}
