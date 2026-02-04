import Footer from "@/components/footer";

export default function ApiDocs({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <div>
      {children}
    </div>
  );
}
