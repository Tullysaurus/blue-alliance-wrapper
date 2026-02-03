import Footer from "@/components/footer";

export default function main({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <div className="relative min-h-screen">
      {children}
      <Footer />
    </div>
  );
}
