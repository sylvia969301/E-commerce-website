/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

/**
 *
 * @author Admin
 */
public class TestLoop {
    public static void main(String[] args) {
        
        
        for(int i=1;i<10;i++){
           for(int j=1;j<10;j++){
               System.out.print(i+"*"+j+"="+i*j );
           if(j==9){
               System.out.println();
           
           }else{
               System.out.print(",\t");
           }
           
         
        }
    }
    }   
}
