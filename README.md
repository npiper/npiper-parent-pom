# neilpiper.me Parent POM file

## What this is?
  
Source code for the parent pom for the Organisation

'neilpiper.me'

```
groupId: neilpiper.me
artifactId: parent.pom

Current Major Version: 0
Suggested Maven Import Range:  (,1.0]  x <= 1.0

```

# How to use the Parent POM?

## Pre-Requisites

 * AWS Storage Repo S3 for Repository
 * github account - OAuth token
 * travis-ci account
 * docker

## New Git project

### Create a new Git project

```
mvn archetype
..
git init
git add . && git commit -am "initial commit"
git remote add origin https://github.com/npiper/[PROJECT_NAME].git
git push origin
```

### Copy a sample travis-ci file and .gitignore

```
wget https://raw.githubusercontent.com/npiper/npiper-parent-pom/master/.gitignore .
wget https://raw.githubusercontent.com/npiper/npiper-parent-pom/master/deploy.sh .
wget https://raw.githubusercontent.com/npiper/npiper-parent-pom/master/.travis.sample .travis.yml
```

### Encrypt keys into .travis.yml

The following encrypted variables are used on a succesful build and `mvn deploy` to the Release repository.

 * Authenticate to S3 Release repo and push deploy image to Repo
 * Git Tag and push to master


```
travis encrypt AWS_ACCESS_KEY_ID=[Your_AWS_Access_Key] --add
travis encrypt AWS_SECRET_KEY=[Your_AWS_Secret_Key] --add
travis encrypt GIT_USER_NAME=npiper --add
travis encrypt GITPW=[Your GIT OAuth] --add
travis encrypt DOCKER_USERNAME=[Your Dockerhub user] --add
travis encrypt DOCKER_PASSWORD=[Your Dockerhub password] --add
```

### Add Repository , overwrite SCM URL in pom.xml

```
  	<!-- REPOSITORIES & PLUGIN REPOSITORIES - chicken/egg for travis-ci -->
	<repositories>
		<!-- public release repo -->
		<repository>
			<id>solveapuzzle-repo</id>
			<url>https://s3-ap-southeast-2.amazonaws.com/solveapuzzle-repo/release/</url>
		</repository>
	</repositories>

	<!-- Workaround to an inconsistency in Maven that child projects scm tag, appends parent's pom name -->
	<scm>
		<url>https://github.com/${githubOrg}/[repo-name]</url>
		<developerConnection>scm:git:https://github.com/${githubOrg}/[repo-name].git</developerConnection>
	</scm>
```


### Choose the Parent

Release versions can be browsed using the 'tags' [https://github.com/npiper/npiper-parent-pom/tags](https://github.com/npiper/npiper-parent-pom/tags)

The parent versions can be browsed at: https://s3-ap-southeast-2.amazonaws.com/solveapuzzle-repo

Release Naming Convention:  *MAJOR.MINOR.PATCH* _BUILD.COMMIT*

```
  <parent>
    <groupId>neilpiper.me</groupId>
    <artifactId>parent.pom</artifactId>
    <version>(,1.0]</version>
  </parent>
```

### Set the project name

A lot of the project inherits location and github projects

```
  <name>hello-world</name>
  ```

## Conventions to follow?

Repository is in Github team.

project.name = GIT repository name

Use git issue tracking (default)

When using `site` put published version into github pages as path `${project.name}`

## Why not test frameworks?

Allow freedom, suggest JUnit by default.

Also consider:
* Powermock
* Mockito

## Code coverage

JaCoco - however Travis-ci may have some difficulties here:
https://blog.frankel.ch/travis-ci-tutorial-for-java-projects/


## Overiding key behaviours?

# Baseline

The initial version is based on developing maven built, Java applications in the following minimum standards.


  * Maven version > 3.5.0
  * Checkstyle Plugin 3.0.0
  * Enforcer Plugin 3.0.0-M1
  * Corbetura code coverage 2.7
  * Java/JDK version >= 1.8

# Validation

 * Maven & JDK at required versions (Enforcer)
 * Checkstyle - Adopt [Google checks](http://checkstyle.sourceforge.net/google_style.html) as default
 * Corbetura code coverage
 * PMD - Copy paste detect
  * https://www.rainerhahnekamp.com/en/ignoring-lombok-code-in-jacoco/
  * JDepend - http://www.mojohaus.org/jdepend-maven-plugin/

# License

[MIT License](https://opensource.org/licenses/mit-license.php)

# Release Baselining (Maven snapshots, releases)

Release versions are baselined into an S3 Bucket owned by
solveapuzzledev.  The extension [maven-s3-wagon](https://github.com/jcaddel/maven-s3-wagon) is used to communicate to S3.  

The build server will need authentication/authorisation to the S3 bucket to deploy releases but read-only access is public.

## Release process

Use semantic versioning in your POM file to consider a release candidate of the change you are intending to make, and the CI server to guide the succesful build candidate to take forward.

Why: You know the change you are after,.. it might take a few builds and tests to get it so the code traceability is always built in.

