-- CreateEnum
CREATE TYPE "Level" AS ENUM ('ADVANCED', 'INTERMEDIATE', 'BASIC');

-- CreateTable
CREATE TABLE "students" (
    "id" UUID NOT NULL,
    "name" VARCHAR(60) NOT NULL,
    "email" VARCHAR(60) NOT NULL,
    "password" VARCHAR(60) NOT NULL,
    "age" SMALLINT,
    "token" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "students_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin" (
    "id" UUID NOT NULL,
    "name" VARCHAR(20) NOT NULL,
    "password" VARCHAR(50) NOT NULL,

    CONSTRAINT "admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "courses" (
    "id" UUID NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "workload" SMALLINT NOT NULL,
    "difficultyLevel" "Level" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "id_student" UUID,

    CONSTRAINT "courses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "topics" (
    "id" UUID NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "id_course" UUID NOT NULL,
    "id_module" UUID NOT NULL,
    "id_exercise" UUID NOT NULL,

    CONSTRAINT "topics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "modules" (
    "id" UUID NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "id_course" UUID NOT NULL,

    CONSTRAINT "modules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exercises" (
    "id" UUID NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "answers" VARCHAR(255) NOT NULL,
    "right_answer" VARCHAR(255) NOT NULL,
    "id_module" UUID NOT NULL,

    CONSTRAINT "exercises_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "classes" (
    "id" UUID NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "id_module" UUID NOT NULL,

    CONSTRAINT "classes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "students_email_key" ON "students"("email");

-- AddForeignKey
ALTER TABLE "courses" ADD CONSTRAINT "courses_id_student_fkey" FOREIGN KEY ("id_student") REFERENCES "students"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "topics" ADD CONSTRAINT "topics_id_course_fkey" FOREIGN KEY ("id_course") REFERENCES "courses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "topics" ADD CONSTRAINT "topics_id_module_fkey" FOREIGN KEY ("id_module") REFERENCES "modules"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "topics" ADD CONSTRAINT "topics_id_exercise_fkey" FOREIGN KEY ("id_exercise") REFERENCES "exercises"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "modules" ADD CONSTRAINT "modules_id_course_fkey" FOREIGN KEY ("id_course") REFERENCES "courses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exercises" ADD CONSTRAINT "exercises_id_module_fkey" FOREIGN KEY ("id_module") REFERENCES "modules"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_id_module_fkey" FOREIGN KEY ("id_module") REFERENCES "modules"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
