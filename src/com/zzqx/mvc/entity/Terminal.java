package com.zzqx.mvc.entity;

import com.jetsum.core.orm.entity.IdEntity;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "tb_terminal")
public class Terminal extends IdEntity {
	
	private int serialNumber;
	private String status;
	private String name;
	private String codeName;
	private String ip;
	private String mac;
	private String remark;
	private Set<TerminalContent> terminalContents;
	private Group group;
	private  int hallId;
	private  int updateStatus;//上传状态（0 未上传 1已上传 2 已更新 ）默认为 0
	
	@OneToMany(mappedBy="terminal")
	public Set<TerminalContent> getTerminalContents() {
		return terminalContents;
	}
	public void setTerminalContents(Set<TerminalContent> terminalContents) {
		this.terminalContents = terminalContents;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "group_id", referencedColumnName = "id", updatable = false, insertable=false)
	@NotFound(action=NotFoundAction.IGNORE)
	public Group getGroup() {
		return group;
	}
	public void setGroup(Group group) {
		this.group = group;
	}
	public int getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(int serialNumber) {
		this.serialNumber = serialNumber;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getHallId() {
		return hallId;
	}

	public void setHallId(int hallId) {
		this.hallId = hallId;
	}

	public int getUpdateStatus() {
		return updateStatus;
	}

	public void setUpdateStatus(int updateStatus) {
		this.updateStatus = updateStatus;
	}
}
