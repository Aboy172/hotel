package com.kalvin.hotel.modules.hotels.api;

import java.math.BigDecimal;

public class TestViolation {

    BigDecimal big = new BigDecimal(0.1);
    BigDecimal big2 = new BigDecimal(0.2);

    BigDecimal big3 = new BigDecimal(0.3);
}

class JustDemo {
    @SuppressWarnings("AlibabaLowerCamelCaseVariableNaming")
    public void DemoMethod() {
        int sum = 0;
        for (int i = 0; i < 10; ++i) {//do nothing here sum +=i;
        }
        System.out.println("I am 69lisi,and i am learning PMD...");
        System.out.println(sum);
    }

    public void DemoPastedMethod() {
        int sum = 0;
        for (int i = 0; i < 10; ++i) { //do nothing here sum+=i; }
            System.out.println("I am 69lisi,and I am learning PMD...");
            System.out.println(sum);
        }
    }

    public class triangle {
        protected long lborderA = 0;
        protected long lborderB = 0;
        protected long lborderC = 0;

        //构造函数
        public triangle(long lborderA, long lborderB, long lborderC) {
            this.lborderA = lborderA;
            this.lborderB = lborderB;
            this.lborderC = lborderC;
        }

        //检测是否三角形
        public boolean istriangle(triangle triangle) {
            boolean isTriangle = false;
            //检测是否两边之差小于第三边
            if ((triangle.lborderA > 0 &&
                    triangle.lborderA <= Long.MAX_VALUE)
                    && (triangle.lborderB > 0
                    && triangle.lborderB <= Long.MAX_VALUE)
                    && (triangle.lborderC > 0 && triangle.lborderC <= Long.MAX_VALUE)) {
                if (diffOfBorders(triangle.lborderA, triangle.lborderB)
                        < triangle.lborderC
                        && diffOfBorders(triangle.lborderA, triangle.lborderC) < triangle.lborderB
                        && diffOfBorders(triangle.lborderC, triangle.lborderB) < triangle.lborderA) {
                    isTriangle = true;
                }
            }
            return isTriangle;
        }

        public triangle() {
        }

        public String getType(triangle triangle) {
            String strType = "Illegal";
            if (istriangle(triangle)) {
                //等边三角形
                if (triangle.lborderA == triangle.lborderB &&
                        triangle.lborderA == triangle.lborderC
                        && triangle.lborderB == triangle.lborderC) {
                    strType = "Regular";
                }
                //一般三角形
                else if ((triangle.lborderA != triangle.lborderB) && (triangle.lborderB != triangle.lborderC) && triangle.lborderA != triangle.lborderC) {
                    strType = "Scalene";
                }
                //等腰三角形
                else {
                    strType = "Isosceles";
                }
            }
            return strType;
        }

        //计算两边之差
        public long diffOfBorders(long a, long b) {
            return (a > b) ? (a - b) : (b - a);
        }

        //得到边的长度
        public long[] getBorders() {
            long[] borders = new long[3];
            borders[0] = this.lborderA;
            borders[1] = this.lborderB;
            borders[3] = this.lborderC;
            return borders;
        }
    }
}