allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory.set(File("../build"))

subprojects {
    afterEvaluate {
        val project = this
        if (project.plugins.hasPlugin("com.android.application") ||
            project.plugins.hasPlugin("com.android.library")) {
            project.extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                compileSdkVersion(36)
                buildToolsVersion = "36.0.0"

                if (this is com.android.build.gradle.LibraryExtension && namespace == null) {
                    namespace = project.group?.toString() ?: "com.example.${project.name}"
                }
            }
        }
    }

    project.layout.buildDirectory.set(File("${rootProject.layout.buildDirectory.get()}/${project.name}"))
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}