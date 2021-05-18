/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.listener;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author Admin
 */
public class ContextListener implements ServletContextListener {
    private final String SITE_MAP = "/MAPPING/siteMap.map";
    
    private static Map<String, String> getSiteMap(String urlPatterns)
                throws IOException {
        File file = new File(urlPatterns);
        FileReader f = null;
        BufferedReader br = null;
        
        Map<String, String> siteMap;
        try {
            if (file.exists()) {
                System.out.println("[ContextListener] file can read.");
                f = new FileReader(urlPatterns);
                br = new BufferedReader(f);
                siteMap = new HashMap<>();
                
                while(br.ready()) {
                    String line = br.readLine();
                    if (line != null) {
                        
                        if (line.charAt(0) != '#') {
                            String[] entry = line.split("=", 2);
                            siteMap.put(entry[0].trim(), entry[1].trim());
                        }
                    }
                }
                return siteMap;
            }
        } finally {
            if (br != null)
                br.close();
            if (f != null)
                f.close();
        }
        
        return null;
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //1. assign a hashmap to read siteMapping file.
        Map<String, String> siteMap = null;
        ServletContext application = sce.getServletContext();
        String filepath = null;
        
        try {
            if (application != null) {
                filepath = application.getRealPath(SITE_MAP);
                siteMap = getSiteMap(filepath);
            }
            System.out.println("filepath: " + filepath);
            if (siteMap != null) {
                System.out.println("[ContextListener] mapping file read successful.");
                for (String key : siteMap.keySet()) {
                    System.out.println("[" + key + "]:[" + siteMap.get(key) + "]");
                }
            } else {
                System.out.println("[ContextListener] mapping file read failed.");
            }
            ServletContext context = sce.getServletContext();
            context.setAttribute("SITE_MAP", siteMap);
        } catch (IOException ex) {
            Logger.getLogger(ContextListener.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
