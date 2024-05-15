-- myProj
workspace "myProj"
    configurations
    {
        "Debug",
        "Release"
    }
    startproject "myProj"
    
    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "myProj"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("../bin/" .. outputdir .. "/%{prj.name}")
    objdir ("../bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/src/main.cpp"


    }

    includedirs
    {
        "../src",
        "usr/include"
    }

    defines
    {
        "GLFW_EXPOSE_NATIVE_WIN32",
        "GLFW_INCLUDE_NONE",
        "myProj_ENABLE_ASSERTS",
        "GLAD_GL_IMPLEMENTATION",
        "FL_INTERNALS",
        "FL_LIBRARY",
        "myProj_ENABLE_ASSERTS" -- debug break enable
    }

    libdirs
    {
        "usr/lib"
    }

    filter "system:windows"
        systemversion "latest"

        defines
        {
            "myProj_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "myProj_DEBUG"
        links
        {
            "fltk"
        }
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "myProj_RELEASE"
        links
        {
            "fltk"
        }
        runtime "Release"
        optimize "on"