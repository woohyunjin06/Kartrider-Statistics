//
//  DProvider+ForceUnwrap.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

extension DependencyProvider {
    
    func resolve<T>() -> T {
        return try! container.resolve()
    }
    
    func resolve<T, Arg1>(
        arguments: Arg1
    ) -> T {
        return try! container.resolve(arguments: arguments)
    }
    
    func resolve<T, Arg1, Arg2>(
        arguments: Arg1,
        _ arg2: Arg2
    ) -> T {
        return try! container.resolve(arguments: arguments, arg2)
    }
    
    func resolve<T, Arg1, Arg2, Arg3>(
        arguments: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3
    ) -> T {
        return try! container.resolve(arguments: arguments, arg2, arg3)
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4>(
        arguments: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4
    ) -> T {
        return try! container.resolve(arguments: arguments, arg2, arg3, arg4)
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5>(
        arguments: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5
    ) -> T {
        return try! container.resolve(arguments: arguments, arg2, arg3, arg4, arg5)
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        arguments: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5,
        _ arg6: Arg6
    ) -> T {
        return try! container.resolve(arguments: arguments, arg2, arg3, arg4, arg5, arg6)
    }
}
