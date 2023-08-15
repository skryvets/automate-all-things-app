plugins {
	java
	id("org.springframework.boot") version "3.1.2"
	id("io.spring.dependency-management") version "1.1.2"
	id("com.google.cloud.tools.jib") version "3.3.2"
}

group = "com.example"
version = "0.0.1-SNAPSHOT"

java {
	sourceCompatibility = JavaVersion.VERSION_17
}

configurations {
	compileOnly {
		extendsFrom(configurations.annotationProcessor.get())
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-web")
	compileOnly("org.projectlombok:lombok")
	annotationProcessor("org.projectlombok:lombok")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<Test> {
	useJUnitPlatform()
}

jib {
	from {
		image = "gcr.io/distroless/java17-debian11"
	}
	to {
		image = "skryvets/${project.rootProject.name}"
		tags = "${project.version},latest".split(",").toSet()
	}
	container {
		creationTime.set("USE_CURRENT_TIMESTAMP")
		ports = listOf("8080")
	}
}
