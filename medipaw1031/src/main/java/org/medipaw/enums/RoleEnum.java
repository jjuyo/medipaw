package org.medipaw.enums;

import com.fasterxml.jackson.annotation.JsonCreator;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum RoleEnum {
	ROLE_ADMIN,
	ROLE_MEMBER,
	ROLE_HOSPITAL;
}
