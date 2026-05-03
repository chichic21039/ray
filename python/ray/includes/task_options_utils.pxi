<<<<<<< HEAD
cdef c_vector[CFunctionDescriptor] prepare_function_descriptors(pyfd_list):
    cdef:
        c_vector[CFunctionDescriptor] fd_list

    fd_list.reserve(len(pyfd_list))
    for pyfd in pyfd_list:
        fd_list.push_back(CFunctionDescriptorBuilder.BuildPython(
            pyfd.module_name, pyfd.class_name, pyfd.function_name, b""))
    return fd_list

cdef int prepare_actor_concurrency_groups(
        dict concurrency_groups_dict,
        c_vector[CConcurrencyGroup] *concurrency_groups):

    cdef:
        c_vector[CFunctionDescriptor] c_fd_list

    if concurrency_groups_dict is None:
        raise ValueError("Must provide it...")

    concurrency_groups.reserve(len(concurrency_groups_dict))
    for key, value in concurrency_groups_dict.items():
        c_fd_list = prepare_function_descriptors(value["function_descriptors"])
        concurrency_groups.push_back(CConcurrencyGroup(
            key.encode("ascii"), value["max_concurrency"], move(c_fd_list)))
    return 1
>>>>>>> 9e3939c6eb2fce96929813baae82dd8a237155c9
