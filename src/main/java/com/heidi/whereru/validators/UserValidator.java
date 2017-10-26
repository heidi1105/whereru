package com.heidi.whereru.validators;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.heidi.whereru.models.User;

@Component
public class UserValidator implements Validator{
    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }
    
    @Override
    public void validate(Object object, Errors errors) {
    		System.out.println("in validator");
        User user = (User) object;
    		System.out.println(user.getUsername());
        if (!user.getPwdcfm().equals(user.getPassword())) {
            // 3
        		System.out.println("pwd not match in validator");
            errors.rejectValue("pwdcfm", "Match");
        }         
    }
}
