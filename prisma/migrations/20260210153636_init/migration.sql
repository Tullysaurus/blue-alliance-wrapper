/*
  Warnings:

  - You are about to drop the column `address` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `country` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `divisionKeys` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `eventCode` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `eventTypeString` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `firstEventCode` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `firstEventId` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `gmapsPlaceId` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `gmapsUrl` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `key` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `lat` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `lng` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `locationName` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `parentEventKey` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `playoffType` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `playoffTypestring` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `postalCode` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `shortName` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `stateProv` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `timezone` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `website` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the `District` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Webcast` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_EventToWebcast` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `eventDistrictEnum` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `eventShort` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstCode` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Made the column `city` on table `Event` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "District" DROP CONSTRAINT "District_eventId_fkey";

-- DropForeignKey
ALTER TABLE "_EventToWebcast" DROP CONSTRAINT "_EventToWebcast_A_fkey";

-- DropForeignKey
ALTER TABLE "_EventToWebcast" DROP CONSTRAINT "_EventToWebcast_B_fkey";

-- AlterTable
ALTER TABLE "Event" DROP COLUMN "address",
DROP COLUMN "country",
DROP COLUMN "divisionKeys",
DROP COLUMN "eventCode",
DROP COLUMN "eventTypeString",
DROP COLUMN "firstEventCode",
DROP COLUMN "firstEventId",
DROP COLUMN "gmapsPlaceId",
DROP COLUMN "gmapsUrl",
DROP COLUMN "key",
DROP COLUMN "lat",
DROP COLUMN "lng",
DROP COLUMN "locationName",
DROP COLUMN "name",
DROP COLUMN "parentEventKey",
DROP COLUMN "playoffType",
DROP COLUMN "playoffTypestring",
DROP COLUMN "postalCode",
DROP COLUMN "shortName",
DROP COLUMN "stateProv",
DROP COLUMN "timezone",
DROP COLUMN "website",
ADD COLUMN     "eventDistrictEnum" INTEGER NOT NULL,
ADD COLUMN     "eventShort" TEXT NOT NULL,
ADD COLUMN     "firstCode" TEXT NOT NULL,
ALTER COLUMN "eventType" SET DATA TYPE TEXT,
ALTER COLUMN "city" SET NOT NULL;

-- DropTable
DROP TABLE "District";

-- DropTable
DROP TABLE "Webcast";

-- DropTable
DROP TABLE "_EventToWebcast";

-- DropEnum
DROP TYPE "WebcastEnum";

-- CreateTable
CREATE TABLE "Team" (
    "id" SERIAL NOT NULL,
    "rookieYear" TEXT NOT NULL,
    "homeCmp" TEXT NOT NULL,
    "firstTpidYear" INTEGER NOT NULL,
    "website" TEXT NOT NULL,
    "schoolName" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "postalCode" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "stateProv" TEXT NOT NULL,
    "motto" TEXT NOT NULL,
    "firstTpid" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "teamNumber" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Team_teamNumber_key" ON "Team"("teamNumber");
