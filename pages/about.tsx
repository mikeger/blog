import React from 'react';
import Layout from '../components/Layout';

export const About = (): JSX.Element => {
  return (
    <Layout
      customMeta={{
        title: 'About - Mike Gerasymenko',
      }}
    >
      <h1>About</h1>
      <h2>Hey there</h2>
      <p>This is a personal blog of Mike Gerasymenko, ukrainian🇺🇦 in Berlin.</p>
      <p>
        Customer and quality focused mobile engineer in love with mobile
        platforms. I&apos;ve been building software for quite a while: over 14
        years of software development experience, 12 years of iOS. I have
        experience working on great products and I am excited to see them used.
      </p>
    </Layout>
  );
};

export default About;
