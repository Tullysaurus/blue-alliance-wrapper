/*
  Warnings:

  - A unique constraint covering the columns `[teamId]` on the table `NormalizedLocation` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "NormalizedLocation" ADD COLUMN     "teamId" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "NormalizedLocation_teamId_key" ON "NormalizedLocation"("teamId");

-- AddForeignKey
ALTER TABLE "NormalizedLocation" ADD CONSTRAINT "NormalizedLocation_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE SET NULL ON UPDATE CASCADE;
