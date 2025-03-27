package com.kalvin.hotel.common.shiro;

import cn.hutool.core.util.StrUtil;
import com.kalvin.hotel.common.constant.SysConstant;
import com.kalvin.hotel.common.utils.CryptionKit;
import com.kalvin.hotel.common.utils.ShiroKit;
import com.kalvin.hotel.modules.sys.entity.User;
import com.kalvin.hotel.modules.sys.service.IMenuService;
import com.kalvin.hotel.modules.sys.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
@Component("frontendUserRealm")
public class FrontendUserRealm extends AuthorizingRealm {
    @Lazy
    @Autowired
    private UserService userService;

    @Lazy
    @Autowired
    private IMenuService menuService;


    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {


        User user = (User)principals.getPrimaryPrincipal();
        Long userId = user.getId();
        String username = user.getUsername();

        List<String> permsList;

        // todo 系统管理员，拥有最高权限（不用在系统设置任何权限）
        /*if (SysConstant.ADMIN.equals(username)) {
            List<Menu> menuList = menuService.list();
            permsList = new ArrayList<>(menuList.size());
            for (Menu menu : menuList) {
                permsList.add(menu.getPermission());
            }
        } else {
            permsList = menuService.getPermission(userId);
        }*/
        permsList = menuService.getPermission(userId);

        //用户权限列表
        Set<String> permsSet = new HashSet<>();
        for(String perms : permsList){
            if(StrUtil.isBlank(perms)){
                continue;
            }
            permsSet.addAll(Arrays.asList(perms.trim().split(",")));
        }

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setStringPermissions(permsSet);

        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {


        UsernamePasswordToken token = (UsernamePasswordToken)authcToken;

        //查询用户信息
        User user = userService.getByUsername(token.getUsername());
        //账号不存在
        if(user == null) {
            throw new UnknownAccountException("账号或密码不正确");
        }

        String password = CryptionKit.genUserPwd(new String((char[]) token.getCredentials()));
        if (!user.getPassword().equals(password)) {
            // 密码错误
            throw new IncorrectCredentialsException("账号或密码不正确");
        }

        if (user.getStatus() != SysConstant.VALID_USER) {
            // 账号锁定
            throw new LockedAccountException("账号已被锁定，请联系管理员");
        }

        return new SimpleAuthenticationInfo(user, user.getPassword(), getName());

    }
    @Override
    public void setCredentialsMatcher(CredentialsMatcher credentialsMatcher) {
        HashedCredentialsMatcher shaCredentialsMatcher = new HashedCredentialsMatcher();
        shaCredentialsMatcher.setHashAlgorithmName(ShiroKit.HASH_ALGORITHM_NAME);
        shaCredentialsMatcher.setHashIterations(ShiroKit.HASH_ITERATIONS);
        super.setCredentialsMatcher(shaCredentialsMatcher);
    }

    /**
     * 清理权限缓存
     */
    public void clearCachedAuthorization() {
        super.clearCachedAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
    }
}